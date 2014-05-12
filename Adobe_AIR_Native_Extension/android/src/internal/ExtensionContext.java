package ${extension.package}.internal;

import java.util.HashMap;
import java.util.Map;
import android.util.Log;
import android.app.Activity;
import android.content.Intent;

import android.os.Build;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import ${extension.package}.internal.functions.*;

public class ${extension.className}Context extends FREContext
{
	public ${extension.className}Context()
	{
		log("Creating ${extension.className}Context");
	}
	
	public void log(String message)
	{
		Log.i("${log.prefix}", message);
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
