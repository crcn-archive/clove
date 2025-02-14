package com.spice.air.utils.sql.manage
{
	import com.spice.recycle.pool.ObjectPoolManager;
	import com.spice.utils.DescribeTypeUtil;
	
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.xml.XMLNode;
	
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	

	public class SQLiteTableMetadataHandler extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Private Variables
		//
		//--------------------------------------------------------------------------
		
		private var _target:IList;
		private var _voUnique:Boolean;
		private var _targetName:String;
		private var _initialized:Boolean;
		private var _targetClass:Class;
		private var _manager:SQLiteTableMetadataManager;
		
		private var _properties:Array;
		
		private var _insertStmt:SQLStatement;
		private var _removeStmt:SQLStatement;
		private var _selectAllStmt:SQLStatement;
		
		new ObjectPoolManager
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		public function SQLiteTableMetadataHandler(manager:SQLiteTableMetadataManager,metadata:XML)
		{
			_targetName = metadata.@name;
			
			
			var voClass:String = metadata..arg.(@key == "voClass").@value;
			
			if(voClass != '' && voClass)
			{
				this._targetClass = DescribeTypeUtil.getDefinitionByName(voClass);
			}
			
			_manager = manager;
			
			
			_target = manager.target[_targetName];
			
			this.listenToTarget();
			
			
			init();
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Private Methods
		//
		//--------------------------------------------------------------------------
		
		/*
		 */
		
		private function init():void
		{
			if(this._initialized)
				return;
			
			if(!this._targetClass && (!_target || _target.length == 0))
				return;
			
			this._initialized = true;
			
			if(this._target.length > 0)
				var sampleData:Object = this._target.getItemAt(0);
			
			var targetClass:Class = this._targetClass ? this._targetClass : DescribeTypeUtil.getDefinitionByObject(sampleData);
			
//			_voUnique = sampleData is IDBUnique
			
			
			var info:XML = DescribeTypeUtil.describeCachedType(targetClass);
			
			var accessors:XMLList = info..accessor.(@access == 'readwrite' && @type != 'Function');
			var cnode:XMLNode;
			
		
			
			this._properties = [];
			var createProps:Array = [];
			var insertProps:Array = [];
			var insertProps2:Array = [];
			
			var n:String;
			
			
			for each(var node:XML in accessors)
			{
				 
				n = node.@name;
				
				if(n == "dbid")
					continue;
				
				createProps.push(n+" TEXT");
				insertProps.push(":"+n);
				insertProps2.push("`"+n+"`");
				this._properties.push(n);	
			}
			
			
			
			var cstmt:SQLStatement = new SQLStatement();
			cstmt.text = "CREATE TABLE IF NOT EXISTS `"+this._targetName+"` (dbid INTEGER PRIMARY KEY AUTOINCREMENT, "+createProps.join(",")+")";
			cstmt.sqlConnection = this._manager.sqlConnection;
			
			cstmt.execute();
			
			
			
			
			_insertStmt = new SQLStatement();
			_insertStmt.text = "INSERT INTO `"+this._targetName+"` ("+insertProps2.join(",")+") VALUES("+insertProps.join(",")+")";
			_insertStmt.sqlConnection = this._manager.sqlConnection;
				
			_removeStmt = new SQLStatement();
			_removeStmt.text = "DELETE FROM `"+this._targetName+"` WHERE `dbid` = :dbid";
			_removeStmt.sqlConnection = this._manager.sqlConnection;
			
			_selectAllStmt = new SQLStatement();
			_selectAllStmt.text = "SELECT * FROM `"+this._targetName+"` WHERE `dbid`";
			_selectAllStmt.itemClass = targetClass;
			_selectAllStmt.sqlConnection = this._manager.sqlConnection;
			
			this.insertItems(this._target.toArray());
			
			
			//fill the target with the stored items
			this.addItemsToTarget();
			
		}
		
		
		
		
		/*
		 */
		
		private function onCollectionChange(event:CollectionEvent):void
		{
			init();
			
			switch(event.kind)
			{
				case CollectionEventKind.ADD:
					this.insertItems(event.items);
				break;
				case CollectionEventKind.REMOVE:
					this.removeItems(event.items);
				break;
				
			}
		}
		
		
		/*
		 */
		
		private function insertItems(items:Array):void
		{
			
			var lid:Number = this._manager.sqlConnection.lastInsertRowID;
			
			this._manager.sqlConnection.begin();
			
			for each(var item:* in items)
			{	
				for each(var property:String in this._properties)
				{
					this._insertStmt.parameters[":"+property] = item[property];
				}
				
				this._insertStmt.execute();
				
				item.dbid = ++lid;
				
			}
			
			this._manager.sqlConnection.commit();
			
			
		}
		
		
		/*
		 */
		
		private function removeItems(items:Array):void
		{
			this._manager.sqlConnection.begin();
			
			for each(var item:* in items)
			{
				this._removeStmt[":dbid"] = item.dbid;
				this._removeStmt.execute();
			}
			
			this._manager.sqlConnection.commit();
		}
		
		
		/*
		 */
		
		private function addItemsToTarget():void
		{
			this.ignoreTarget();
			
			this._selectAllStmt.execute();
			
			Object(this._target).source = this._selectAllStmt.getResult().data;
			
			this.listenToTarget();
		}
		
		
		/*
		 */
		
		private function ignoreTarget():void
		{
			this._target.removeEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionChange);
		}
		
		/*
		 */
		
		private function listenToTarget():void
		{
			this.ignoreTarget();
			this._target.addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionChange);
		}
	}
}