package com.swfjunkie.tweetr.data.objects
{	
    /*
      Direct Message Data Object 
      @author Sandro Ducceschi [swfjunkie.com, Switzerland]
     */
   
    public class DirectMessageData
    {
        //--------------------------------------------------------------------------
        //
        //  Class variables
        //
        //--------------------------------------------------------------------------

        //--------------------------------------------------------------------------
        //
        //  Initialization
        //
        //--------------------------------------------------------------------------
        public function DirectMessageData( id:Number = 0,
                                           senderId:int = 0,
                                           text:String = null,
                                           recipientId:int = 0,
                                           createdAt:String = null,
                                           senderScreenName:String = null,
                                           recipientScreenName:String = null,
                                           sender:UserData = null,
                                           recipient:UserData = null ) 
        {
        	
            this.id = id;
            this.senderId = senderId;
            this.text = text;
            this.recipientId = recipientId;
            this.createdAt = createdAt;
            this.senderScreenName = senderScreenName;
            this.recipientScreenName = recipientScreenName;
            this.user      = sender;
            this.recipient = recipient;
        }
        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------
        
        public var user:UserData;
        
        public var id:Number;
        public var senderId:int;
        public var text:String;
        public var recipientId:int;
        public var createdAt:String;
        public var senderScreenName:String;
        public var recipientScreenName:String;
        
        public var recipient:UserData;
        //--------------------------------------------------------------------------
        //
        //  API
        //
        //--------------------------------------------------------------------------
    }
}