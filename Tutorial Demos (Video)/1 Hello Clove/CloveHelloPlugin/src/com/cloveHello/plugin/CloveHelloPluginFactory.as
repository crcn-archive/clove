package com.cloveHello.plugin
{
	import com.cloveHello.plugin.icons.CloveHelloPluginIcon;
	import com.spice.clove.plugin.IClovePlugin;
	import com.spice.clove.plugin.IPluginFactory;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.utils.storage.INotifiableSettings;
	import com.spice.utils.storage.TempSettings;
	
	public class CloveHelloPluginFactory implements IPluginFactory
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveHelloPluginFactory()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get metadata():INotifiableSettings
		{
			return null;
		}
		
		/**
		 */
		
		public function get installer():IServiceInstaller
		{
			return null;
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
			return new CloveHelloPlugin();
		}

	}
}