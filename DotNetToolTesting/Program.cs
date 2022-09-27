// See https://aka.ms/new-console-template for more information


using System.Reflection;

var executePath = Assembly.GetExecutingAssembly().Location;
var entryPath = Assembly.GetEntryAssembly().Location;
var callingPath = Assembly.GetCallingAssembly().Location;
var currentWorkingDir = Directory.GetCurrentDirectory();

Console.WriteLine($"Working Dir: {currentWorkingDir}");
Console.WriteLine($"Execute Path: {executePath}");
Console.WriteLine($"Entry Path: {entryPath}");
Console.WriteLine($"Calling Path: {callingPath}");
