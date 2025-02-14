package com.cloveHello.plugin
{
	import com.cloveHello.plugin.column.controller.HelloCloveColumnController;
	import com.spice.clove.plugin.ClovePlugin;
	import com.spice.clove.plugin.column.control.ColumnControllerFactory;
	import com.spice.clove.plugin.control.IPluginController;
	
	import mx.controls.Alert;
	
	public class CloveHelloPlugin extends ClovePlugin
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _settings:CloveHelloPluginSettings;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveHelloPlugin()
		{
			_settings = new CloveHelloPluginSettings();
			
			super(_settings);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get settings():CloveHelloPluginSettings
		{
			return this._settings;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function initialize(controller:IPluginController):void
		{
			super.initialize(controller);
				
			this.testHello();
			
			this.addAvailableColumnController(new ColumnControllerFactory("Hello Column",controller,HelloCloveColumnController));
			
			this.complete();
		}
		
		
		/**
		 */
		
		public function testHello():void
		{
			Alert.show("Hello "+_settings.userName+"!","Hello");
		}
		
		

	}
}