/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package com.facebook.commands.photos {
	
	import com.facebook.data.photos.FacebookPhoto;
	import com.facebook.net.FacebookCall;
	import com.facebook.net.IUploadPhoto;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The UploadPhoto class represents the public  
      Facebook API known as Photos.upload.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.upload
	 */
	public class UploadPhoto extends FacebookCall implements IUploadPhoto {

		
		public static const METHOD_NAME:String = 'photos.upload';
		public static const SCHEMA:Array = ['data', 'aid', 'caption', 'uid'];
		
		public var aid:String;
		public var caption:String;
		public var uid:String;
		public var uploadedPhoto:FacebookPhoto;
		
		protected var _data:Object;
		
		/**
		 * Used to change type of Uploaded photos, used to automatically Convert BitmapData into an facebook supported Image.
		 * @see UploadPhotoTypes
		 * 
		 */
		protected var _uploadType:String = UploadPhotoTypes.PNG;
		
		/**
		 * Used to assign the quality to an UploadPhotoTypes.JPEG uploadType; 
		 * 
		 */
		protected var _uploadQuality:uint = 80;
		
		public function get data():Object { return _data; }
		public function set data(value:Object):void { _data = value; }
		
		public function get uploadType():String { return _uploadType; }
		public function set uploadType(value:String):void { _uploadType = value; }
		
		public function get uploadQuality():uint { return _uploadQuality; }
		public function set uploadQuality(value:uint):void { _uploadQuality = value; }
		
		public function UploadPhoto(data:Object=null, aid:String=null, caption:String=null, uid:String = null) {
			super(METHOD_NAME);
			
			this.data = data;
			this.aid = aid;
			this.caption = caption;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, data, aid, caption, uid);
			super.facebook_internal::initialize();
		}
	}
}