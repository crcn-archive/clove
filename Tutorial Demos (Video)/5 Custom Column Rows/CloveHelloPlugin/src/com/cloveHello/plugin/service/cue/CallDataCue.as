package com.cloveHello.plugin.service.cue
{
	import com.cloveHello.plugin.service.vo.MessageVO;
	import com.spice.utils.queue.cue.CueStateType;
	import com.spice.utils.queue.cue.StateCue;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class CallDataCue extends StateCue
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _startIndex:int;
		private var _length:Number;
		private var _data:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CallDataCue(start:int,length:int = 100)
		{
			_startIndex = start;
			_length     = length;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get data():Array
		{
			return _data;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function init():void
		{
			super.init();
			
			var n:Number = _startIndex + _length;
			
			var data:Array = [];
			
			var now:Date = new Date();
			
			
			for(var i:int = 0; i < n; i++)
			{
				data.push(new MessageVO(i.toString(),"Title - "+i,"Message - "+i,new Date(now.getTime() - 1000 * 60 * 60 * 24 * i)));
					
			}
			
			_data = data;
			
			
			flash.utils.setTimeout(onTimeout,1000);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onTimeout():void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
			
			this.complete(CueStateType.COMPLETE);
		}

	}
}