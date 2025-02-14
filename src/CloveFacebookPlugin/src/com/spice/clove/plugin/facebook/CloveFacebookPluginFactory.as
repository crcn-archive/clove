package com.spice.clove.plugin.facebook
{
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.PluginFactory;
	import com.spice.clove.plugin.facebook.icons.FacebookIcons;
	import com.spice.clove.plugin.facebook.install.FacebookServiceInstaller;
	import com.spice.clove.plugin.install.IServiceInstaller;
	
	
	[Bindable] 
	public class CloveFacebookPluginFactory extends PluginFactory implements IPluginFactory
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
        public var installer:IServiceInstaller = new FacebookServiceInstaller();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CloveFacebookPluginFactory()
		{
			
			super({name:"Facebook",favicon: FacebookIcons.FACEBOOK_ICON_16});
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function newPlugin():IClovePlugin
		{
			
			return new CloveFacebookPlugin();
		}
	}
}