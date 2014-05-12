package com.bananadragon.extension.internal;

import java.util.HashMap;
import java.util.Map;
import android.util.Log;
import android.app.Activity;
import android.content.Intent;

import android.os.Build;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.bananadragon.extension.internal.functions.*;

public class ExtensionContext extends FREContext
{
	public ExtensionContext()
	{
		log("Creating ExtensionContext");
	}
	
	public void log(String message)
	{
		Log.i("BananaDragonExtension", message);
	}
	
	public void dispatchEvent(String eventName, String eventData)
	{
		log("Event: " + eventName + ", data: " + eventData);
		if (eventData == null)
		{
			eventData = "OK";
		}
		
		dispatchStatusEventAsync(eventName, eventData);
	}
	
	public void dispatchEvent(String eventName)
	{
		dispatchEvent(eventName, "OK");
	}
	
	@Override
	public void dispose() 
	{
	}

	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		log("Setting up functions map");
		
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put("setup", new SetupFunction());
		
		return functionMap;
	}
}
