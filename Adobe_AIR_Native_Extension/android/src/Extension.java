package ${extension.package};

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import ${extension.package}.internal.ExtensionContext;

public class ${extension.className} implements FREExtension
{
	public static ExtensionContext extensionContext;
	
	@Override
	public FREContext createContext(String arg0) 
	{
		if(${extension.className}.extensionContext == null)
			${extension.className}.extensionContext = new ExtensionContext();
		
		return ${extension.className}.extensionContext;
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
