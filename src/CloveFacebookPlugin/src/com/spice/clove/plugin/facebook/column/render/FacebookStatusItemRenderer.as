package com.spice.clove.plugin.facebook.column.render
{
	import com.facebook.data.stream.ProfileData;
	import com.facebook.data.stream.StreamMediaData;
	import com.facebook.data.stream.StreamStoryData;
	import com.spice.clove.plugin.column.render.IReusableCloveColumnItemRenderer;
	import com.spice.clove.plugin.column.render.RenderedColumnData;
	import com.spice.clove.plugin.facebook.column.render.attach.RenderedColumnDataCommentAttachment;
	import com.spice.clove.plugin.facebook.column.render.attach.RenderedColumnDataPhotoAttachment;
	import com.spice.clove.plugin.facebook.data.FriendInfo;
	import com.spice.clove.plugin.facebook.model.FacebookModelLocator;
	
	import mx.binding.utils.BindingUtils;
	
	dynamic public class FacebookStatusItemRenderer implements IReusableCloveColumnItemRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const PROFILE_ROW:String = "profileRow";
        public static const MEDIA_ROW:String = "mediaRow";
        public static const STORY_ROW:String = "storyRow";
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		
		[Bindable] 
		private var _model:FacebookModelLocator = FacebookModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FacebookStatusItemRenderer(viewClass:Class = null)
		{
			if(viewClass)
			{
				this.viewClass = viewClass;
			}
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function getUID(vo:Object):String
		{
			if(vo is StreamStoryData)
			{
				return vo.post_id;
			}
			else
			if(vo is StreamMediaData)
			{
				return vo.href;
			}
			else
			if(vo is ProfileData)
			{
			}
			
			return null
		}
		
		/**
		 */
		
		public function getRenderedData(vo:Object):RenderedColumnData
		{
			
			
			//this is OK since friends are loaded on plugin init
			
			var uid:*;
			var icon:* = null
			var title:String = "";
			var message:String;
			var commentCount:int;
			
			var ssd:StreamStoryData
			if(vo is StreamStoryData)
			{
				ssd = StreamStoryData(vo);
				
				
				uid = ssd.post_id;
				message = ssd.message;
				commentCount = ssd.comments.count;
			}
			else
			if(vo is StreamMediaData)
			{
				uid     = StreamMediaData(vo).href;
				message = uid;
			}
			else
			if(vo is ProfileData)
			{
				uid = "";//ProfileData(vo).id;
			}
		
			
			var rdata:RenderedColumnData = new RenderedColumnData().construct(uid,vo.created_time,title,message,icon,vo);//{source:vo.source_id,post_id:vo.post_id}
			
			//if there is more than one comment, then add an attachment
			
			for each(var att:* in ssd.attachment.media)
			{
				
				if(att.photo)
				{
					rdata.addAttachment(new RenderedColumnDataPhotoAttachment(att.photo,att.src));
					
				}
			}
			
			if(commentCount > 0)
			{
				rdata.addAttachment(new RenderedColumnDataCommentAttachment("View "+commentCount+" comments"));
			}
			
			return rdata;
		}
		
       	
		
		/**
		 */
		
		public function reuse(data:RenderedColumnData):void
		{
			
			//reset the friend info incase it hasn't loaded
			var info:FriendInfo = _model.friendModel.getFriendInfo(data.vo.source_id);
			
			if(!info)
				return;
			
			info.bindRenderedData(data);
			
			
			BindingUtils.bindProperty(data,"icon",info,"pic_square",false)
		}
	}
}