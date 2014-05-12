package com.bananadragon.setupwizard;
import haxe.Json;
import haxe.Utf8;
import sys.FileStat;
import sys.FileSystem;
import sys.io.File;
using StringTools;

/**
 * ...
 * @author HerpyDerpy
 */
class Template
{
	public var name:String;
	public var directory:String;
	
	public function new(directory:String, name:String) 
	{
		this.name = name;
		this.directory = directory;
	}
	
	public function run(args:Array<String>, outputDirectory:String):Void
	{
		if (!FileSystem.exists(directory + "\\wizard.json"))
		{
			Sys.println('Invalid template \'${name}\', wizard.json file does not exist.');
			return;
		}
		
		var fileString:String = File.getContent(directory + "\\wizard.json");
		var wizard:Dynamic = Json.parse(fileString);
		
		var variables:Array<Dynamic> = wizard.variables;
		var advanced:Array<Dynamic> = wizard.advanced_variables;
		var code:Array<Dynamic> = wizard.code_directories;
		var additional:Array<Dynamic> = wizard.additional_directories;
		var copy:Array<Dynamic> = wizard.copy;
		
		var outputPackage:String = "";
		
		//parse variables
		var i:Int = 0;
		while(i < args.length)
		{
			for (j in variables)
			{
				if (args[i] == '-${j[0]}')
				{
					j[1] = args[i + 1];
					
					if (args[i] == "-extension.package")
					{
						outputPackage = args[i + 1];
					}
					
					i++;
					break;
				}
			}
			
			i++;
		}
		
		//remove output if it already exists
		if (FileSystem.exists(outputDirectory))
		{
			FileSystem.deleteDirectory(outputDirectory);
		}
		
		var outputPackageDir:String = outputPackage;
		outputPackageDir = outputPackageDir.replace(".", "\\");
			
		//create basic directories
		FileSystem.createDirectory(outputDirectory);
		for (codeDir in code)
		{
			var directory:String = outputDirectory + "\\" + codeDir + "\\" + outputPackageDir;
			FileSystem.createDirectory(directory);
		}
		
		for (additionalDir in additional)
		{
			FileSystem.createDirectory(outputDirectory + "\\" + additionalDir);
		}
		
		//create files
		for (codeDir in code)
		{
			if (!FileSystem.exists(directory + "\\" + codeDir))
				continue;
				
			var paths:Array<String> = parseDirectory(directory + "\\" + codeDir);
			for (file in paths)
			{
				var path:String = directory + "\\" + codeDir + "\\" + file;
				var content:String = parseContent(File.getContent(path), variables);
				var outputPath:String = outputDirectory + "\\" + codeDir + "\\" + outputPackageDir + "\\" + file;
				
				FileSystem.createDirectory(outputPath.substring(0, outputPath.lastIndexOf("\\")));
				File.saveContent(outputPath, content);
			}
		}
		
		for (additionalDir in additional)
		{
			if (!FileSystem.exists(directory + "\\" + additionalDir))
				continue;
				
			var paths:Array<String> = parseDirectory(directory + "\\" + additionalDir);
			for (file in paths)
			{
				var path:String = directory + "\\" + additionalDir + "\\" + file;
				var content:String = parseContent(File.getContent(path), variables);
				var outputPath:String = outputDirectory + "\\" + additionalDir + "\\" + file;
				
				FileSystem.createDirectory(outputPath.substring(0, outputPath.lastIndexOf("\\")));
				File.saveContent(outputPath, content);
			}
		}
		
		for (file in copy)
		{
			var outputPath:String = outputDirectory + "\\" + file;
			
			FileSystem.createDirectory(outputPath.substring(0, outputPath.lastIndexOf("\\")));
			File.saveBytes(outputPath, File.getBytes(directory + "\\" + file));
		}
	}
	
	public function parseContent(base:String, variables:Array<Dynamic>):String
	{
		var out:String = base;
		for (i in variables)
		{
			out = out.replace("${" + i[0] + "}", i[1]);
		}
		
		return out;
	}
	
	public function parseDirectory(directory:String, prefix:String = ""):Array<String>
	{
		var tmp:Array<String> = FileSystem.readDirectory(directory);
		var out:Array<String> = new Array<String>();
		
		var i:Int = 0;
		while(i < tmp.length)
		{
			if (FileSystem.isDirectory(directory + "\\" + tmp[i]))
			{
				var add:Array<String> = parseDirectory(directory + "\\" + tmp[i], prefix + tmp[i] + "\\");
				for (j in add)
				{
					out.push(j);
				}
			}else {
				out.push(prefix + tmp[i]);
			}
			
			i++;
		}
		
		return out;
	}
}