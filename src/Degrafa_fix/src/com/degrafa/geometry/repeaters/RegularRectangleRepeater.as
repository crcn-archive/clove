////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2008 The Degrafa Team : http://www.Degrafa.com/team
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////
package com.degrafa.geometry.repeaters{
	
	import com.degrafa.geometry.RegularRectangle;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	
	//--------------------------------------
	//  Other metadata
	//--------------------------------------
	
	[IconFile("RegularRectangleRepeater.png")]
	
	[Bindable]
	/**
 	*  The RegularRectangleRepeater element draws a regular rectangle using the specified x,y,
 	*  width and height. Then progressively repeats the rectangle using count and offsets.
 	*  
 	*  @see http://samples.degrafa.com/RegularRectangleRepeater/RegularRectangleRepeater.html
 	*  
 	**/	
	public class RegularRectangleRepeater extends Repeater{
		
		/**
	 	* Constructor.
	 	*  
	 	* <p>The regular rectangle constructor accepts 4 optional arguments that define it's 
	 	* x, y, width and height; as well as 5 arguments for the count and offsets.</p>
	 	* 
	 	* @param x A number indicating the upper left x-axis coordinate.
	 	* @param y A number indicating the upper left y-axis coordinate.
	 	* @param width A number indicating the width.
	 	* @param height A number indicating the height.
	 	* @param count A number indicating the repeat count of rectangles.
	 	* @param offsetX A number indicating the x-axis offset of each rectangle repeated.
	 	* @param offsetY A number indicating the y-axis offset of each rectangle repeated.
	 	* @param offsetWidth A number indicating the width offset of each rectangle repeated.
	 	* @param offsetHeight A number indicating the height offset of each rectangle repeated.  
	 	*/
		public function RegularRectangleRepeater(x:Number=0,y:Number=0,width:Number=0,
		height:Number=0,count:Number=0,offsetX:Number=0,offsetY:Number=0,
		offsetWidth:Number=0,offsetHeight:Number=0){
			
			super();
			
			this.x=x;
			this.y=y;
			this.width=width;
			this.height=height;
			
			super.count =count;
			super.offsetX=offsetX;
			super.offsetY=offsetY;
			
			this.offsetWidth=offsetWidth;
			this.offsetHeight=offsetHeight;
			
		}
		
		/**
		* RegularRectangleRepeater short hand data value.
		* 
		* <p>The regular rectangle data property expects exactly 4 values x, 
		* y, width and height separated by spaces.</p>
		* 
		* @see Geometry#data
		* 
		**/
		override public function set data(value:String):void{			
			if(super.data != value){
				super.data = value;
			
				//parse the string on the space
				var tempArray:Array = value.split(" ");
				
				if (tempArray.length == 4){
					_x=tempArray[0];
					_y=tempArray[1];
					_width=tempArray[2];
					_height=tempArray[3];
				}	
				
				invalidated=true;
				
			}
		} 
				
		private var _offsetWidth:Number=0;
		/**
		* The offsetWidth value sets the width offset of the repeated rectangles. 
		* If not specified a default value of 0 is used.
		**/
		public function get offsetWidth():Number{
			return _offsetWidth;
		}
		public function set offsetWidth(value:Number):void{
			if(_offsetWidth != value){
				_offsetWidth = value;
				invalidated=true;
			}
		}
		
		private var _offsetHeight:Number=0;
		/**
		* The offsetHeight value sets the height offset of the repeated rectangles. 
		* If not specified a default value of 0 is used.
		**/
		public function get offsetHeight():Number{
			return _offsetHeight;
		}
		public function set offsetHeight(value:Number):void{			
			if(_offsetHeight != value){
				_offsetHeight = value;
				invalidated=true;
			}
			
		}
		
		private var _x:Number=0;
		/**
		* The x-axis coordinate of the upper left point of the first rectangle. If not specified 
		* a default value of 0 is used.
		**/
		override public function get x():Number{
			return _x;
		}
		override public function set x(value:Number):void{
			if(_x != value){
				_x = value;
				invalidated=true;
			}
		}
		
		private var _y:Number=0;
		/**
		* The y-axis coordinate of the upper left point of the first rectangle. If not specified 
		* a default value of 0 is used.
		**/
		override public function get y():Number{
			return _y;
		}
		override public function set y(value:Number):void{
			if(_y != value){
				_y = value;
				invalidated=true;
			}
		}
						
		private var _width:Number=0;
		/**
		* The width of the first rectangle.
		**/
		override public function get width():Number{
			return _width;
		}
		override public function set width(value:Number):void{
			if(_width != value){
				_width = value;
				invalidated=true;
			}
		}
		
		private var _height:Number=0;
		/**
		* The height of the first rectangle.
		**/
		override public function get height():Number{
			return _height;
		}
		override public function set height(value:Number):void{
			if(_height != value){
				_height = value;
				invalidated=true;	
			}
		}
		
		private var _bounds:Rectangle;
		/**
		* The tight bounds of this element as represented by a Rectangle object. 
		**/
		override public function get bounds():Rectangle{
			return _bounds;	
		}
		
		
		/**
		* Calculates the bounds for this element. 
		**/
		private function calcBounds(unionRectangle:Rectangle):void{
			
			if(_bounds){
				_bounds = _bounds.union(unionRectangle);
			}
			else{
				_bounds = unionRectangle;
			}
		}	
		
		/**
		* @inheritDoc 
		**/
		override public function preDraw():void{
			if(invalidated){
				
				objectStack=[];
				_bounds = null;
				
				var newRegularRectangle:RegularRectangle;
				
	    	    //loop calc and add the circle for each count    	
	        	for (var i:int = 0;i< count;i++){	
	        		
	    			newRegularRectangle = new RegularRectangle(x,y,width,height);
	    		  	
	    		  	newRegularRectangle.stroke = stroke;
	    			newRegularRectangle.fill = fill;
	        		
	        		newRegularRectangle.x = x + (i*offsetX);
        			newRegularRectangle.y = y + (i*offsetY);
        			newRegularRectangle.width = width + (i*offsetWidth);
        			newRegularRectangle.height = height + (i*offsetHeight);
        		
					//add to the bounds
					newRegularRectangle.preDraw();
        			calcBounds(newRegularRectangle.bounds);
        		
        			objectStack.push(newRegularRectangle);
        		
				}
			
				invalidated=false;	
			}
		}
		
		/**
		* An Array of geometry objects that make up this repeater. 
		**/
		protected var objectStack:Array=[];			
		
		/**
		* Begins the draw phase for geometry objects. All geometry objects 
		* override this to do their specific rendering.
		* 
		* @param graphics The current context to draw to.
		* @param rc A Rectangle object used for fill bounds. 
		**/
		override public function draw(graphics:Graphics,rc:Rectangle):void{	
			
			preDraw();
			
        	var item:RegularRectangle;
        	
        	for each (item in objectStack){
        		//draw the item
				item.draw(graphics,rc);
			}
			
	    }
	}
}