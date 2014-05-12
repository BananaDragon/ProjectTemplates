package ${extension.package}
{
	import flash.events.EventDispatcher;
	
	public class ExtensionInternal extends EventDispatcher
	{
		public static var _isSetup:Boolean;
		private static var eventProxy : ExtensionInternal;
		
		//Redirect public event listeners to the internal event proxy
		public static function addEventListener(type:String, func:Function):void
		{
			_SetupInternal();
			
			eventProxy.addEventListener(type, func);
		}
		
		//Redirect public event listeners to the internal event proxy
		public static function removeEventListener(type:String, func:Function):void
		{
			_SetupInternal();
			
			eventProxy.removeEventListener(type, func);
		}
		
		//Setup internal context and event proxy.
		private static function _SetupInternal():void
		{
			if (_isSetup)
				return;
				
			if (!eventProxy)
			{
				eventProxy = new ExtensionInternal();
			}else {
				throw("Extension context already exists.");
			}
			
			_isSetup = true;
		}
		
		public static function setup():void
		{
			_SetupInternal();
		}
		
		public static function isSupported():Boolean
		{
			return false;
		}
	}
}