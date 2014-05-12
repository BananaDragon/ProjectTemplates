package com.bananadragon.extension
{
	import flash.external.ExtensionContext;
	
	public class ExtensionUtil
	{
		public static function CreateContext(contextType:String = null):ExtensionContext
		{	
			var context:ExtensionContext = ExtensionContext.createExtensionContext("com.bananadragon.extension", contextType);
			if (!context)
			{
				if(contextType == null)
					throw("Failed to create extensions context.");
				else
					throw("Failed to create extension context for '" + contextType + "'.");
					
				return null;
			}
			
			return context;
		}
	}
}