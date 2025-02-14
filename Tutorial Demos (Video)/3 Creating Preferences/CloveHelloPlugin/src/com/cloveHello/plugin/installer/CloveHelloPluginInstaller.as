package com.cloveHello.plugin.installer
{
	import com.cloveHello.plugin.CloveHelloPlugin;
	import com.cloveHello.plugin.icons.CloveHelloPluginIcon;
	import com.spice.clove.plugin.control.IPluginController;
	import com.spice.clove.plugin.install.IServiceInstaller;
	import com.spice.clove.plugin.install.ServiceInstaller;
	
	import mx.controls.Alert;
	
	public class CloveHelloPluginInstaller extends ServiceInstaller implements IServiceInstaller
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var userName:String;
        
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CloveHelloPluginInstaller()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get icon():*
		{
			return CloveHelloPluginIcon.CLOVE_HELLO_ICON_32;
		}
		
		/**
		 */
		
		public function get installViewClass():Class
		{
			return CloveHelloPluginInstallerView;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function check():void
		{
			if(!this.userName || this.userName == "")
			{
				Alert.show("Please enter a username!");
			}
			else
			{
				this.completeInstallation();
			}
		}
		
		/**
		 */
		
		public function init():void
		{
			
		}
		
		/**
		 */
		
		public function install(controller:IPluginController):void
		{
			var plugin:CloveHelloPlugin = CloveHelloPlugin(controller.plugin);
			plugin.settings.userName = this.userName;
		}

	}
}