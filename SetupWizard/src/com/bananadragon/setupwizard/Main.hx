package com.bananadragon.setupwizard;

import haxe.Json;
import sys.io.File;

/**
 * ...
 * @author HerpyDerpy
 */

class Main 
{
	public static var templates:Array<Template>;
	public static function main():Void
	{
		loadTemplates();
		
		var args:Array<String> = Sys.args();
		if (args.length < 2)
		{
			printHelp();
			return;
		}
		
		var templateName:String = "";
		var output:String = "";
		
		var i:Int = 0;
		while(i < args.length)
		{
			if (args[i] == "-template")
			{
				i++;
				templateName = args[i];
				
				//ugly
				args.splice(i - 1, 2);
				i -= 2;
			}else if (args[i] == "-output")
			{
				i++;
				output = args[i];
				
				//ugly
				args.splice(i - 1, 2);
				i -= 2;
			}
			
			i++;
		}
		
		var template:Template = getTemplate(templateName);
		if (template == null)
		{
			Sys.println('Unknown template: ${template.name}');
			printHelp();
			return;
		}
		
		Sys.println('Using template: ${template.name}');
		template.run(args, output);
	}
	
	public static function loadTemplates():Void
	{
		Main.templates = new Array<Template>();
		
		var json:Dynamic = Json.parse(File.getContent("templates.json"));
		var templates:Array<Dynamic> = json.templates;
		for (i in templates)
		{
			var dir:String = i[0];
			var name:String = i[1];
			
			Main.templates.push(new Template(dir, name));
		}
	}
	
	public static function printHelp():Void
	{
		Sys.println("SetupWizard -template <templateName> -output <outputDir> [-<variable> <value>]");
		Sys.println("Available templates:");
		for (i in templates)
		{
			Sys.println('    - ${i.name}');
		}
		
		Sys.println("Example:");
		Sys.println("SetupWizard -template ANETemplate -output ExtensionDir -extension.package com.myawesome.company -extension.className Extension");
	}
	
	public static function getTemplate(name:String):Template
	{
		for (i in templates)
		{
			if (i.name == name)
				return i;
		}
		
		return null;
	}
}