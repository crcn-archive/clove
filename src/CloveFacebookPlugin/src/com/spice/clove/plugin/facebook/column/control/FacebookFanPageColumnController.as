package com.spice.clove.plugin.facebook.column.control
{
	import com.facebook.commands.pages.GetPageInfo;
	import com.facebook.commands.stream.GetFilters;
	import com.facebook.commands.stream.GetStream;
	import com.facebook.data.pages.PageInfoData;
	import com.facebook.data.stream.GetFiltersData;
	import com.facebook.data.stream.GetStreamData;
	import com.spice.clove.events.CloveColumnEvent;
	import com.spice.clove.plugin.facebook.column.render.FacebookFanPageItemRenderer;
	import com.spice.clove.plugin.facebook.cue.FacebookCallCue;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	
	import mx.binding.utils.BindingUtils;

	public class FacebookFanPageColumnController extends FacebookColumnController
	{
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
		//
		//  Public Variables
		//
		//--------------------------------------------------------------------------
		
		
		[Bindable] 
		[Setting]
		public var fanPage:PageInfoData;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		public function FacebookFanPageColumnController()
		{
			
			var fanPageRenderer:FacebookFanPageItemRenderer = new FacebookFanPageItemRenderer();
			
			super(null,fanPageRenderer);
			
			
			BindingUtils.bindProperty(this,"title",this,["fanPage","name"]);
			BindingUtils.bindProperty(fanPageRenderer,"fanPage",this,"fanPage");
		}
		
		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function onColumnStartLoad(event:CloveColumnEvent) : void
		{
			var now:Date = new Date();
			var lastWeek:Date = new Date(now.getTime() - (1000*60*60*24*20));//20 days prior
			
			//NOTE: for some reason, either Facebook caches requests, or something is screwy. newer content
			//doesn't show right away
			
			
			
			var stream:GetStream = new GetStream(_model.facebookID,[this.fanPage.page_id],lastWeek,now,30,"3");
			
			
			var cue:FacebookCallCue = new FacebookCallCue(stream,onGreamData);
			
			this.setLoadCue(cue);
			
			cue.init();
//			new FacebookCallCue(new GetFilters(this.fanPage.page_id.toString()),onGetFilters).init();
		}
		
		
		/**
		 */
		
		private function onGreamData(data:GetStreamData):void
		{
			this.fillColumn(data.stories.source);
		}
		
		
		/*private function onGetFilters(data:GetFiltersData):void
		{
			
			
			
		}*/
		
	}
}