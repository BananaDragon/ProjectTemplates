package com.bananadragon.extension;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.bananadragon.extension.internal.ExtensionContext;

public class Extension implements FREExtension
{
	public static ExtensionContext extensionContext;
	
	@Override
	public FREContext createContext(String arg0) 
	{
		if(Extension.extensionContext == null)
			Extension.extensionContext = new ExtensionContext();
		
		return Extension.extensionContext;
	}

	@Override
	public void dispose() 
	{
	}

	@Override
	public void initialize() 
	{
	}

}
