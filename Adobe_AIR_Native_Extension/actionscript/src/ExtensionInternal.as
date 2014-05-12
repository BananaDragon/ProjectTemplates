package ${extension.package}
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class ExtensionInternal extends EventDispatcher
	{
		public static var _isSetup:Boolean;
		private static var context : ExtensionContext;
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
				
			if (!context)
			{
				context = ExtensionUtil.CreateContext();
				
				eventProxy = new ExtensionInternal();
				context.addEventListener(StatusEvent.STATUS, OnStatus);
			}else {
				throw("Extension context already exists.");
			}
			
			_isSetup = true;
		}
		
		public static function setup():void
		{
			_SetupInternal();
			
			context.call("setup");
		}
		
		public static function isSupported():Boolean
		{
			return true;
		}
		
		public static function OnStatus(e:StatusEvent):void
		{
		}
	}
}