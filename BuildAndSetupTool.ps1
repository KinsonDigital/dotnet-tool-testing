$baseSoftwareDevDirPath = "K:\SOFTWARE DEVELOPMENT";
$personalSoftware = "TESTING";
$projectName = "MyTool";
$packageName = "MyTool";
$solutionDirPath = "$baseSoftwareDevDirPath/$personalSoftware/$projectName";
$projectFilePath = "$solutionDirPath/$projectName/$projectName.csproj";
$nugetOutputPath = "./package";
$packageSourcePath = $nugetOutputPath;

$scriptPath = "$PSScriptRoot";
$configPath = "$scriptPath/.config";

# Delete the dotnet tool manifest if it exists
if (Test-Path -Path $configPath) {
    Remove-Item -Path $configPath -Force -Recurse -Confirm:$false;
    Write-Host "✅DotNet tool manifest deleted.";
}

# Delete the cached nuget package tool
$nugetCacheFilePath = "C:/Users/$env:UserName/.nuget/packages/$packageName";
if (Test-Path -Path $nugetCacheFilePath)
{
    Remove-Item -Path $nugetCacheFilePath -Force -Recurse -Confirm:$false;
    Write-Host "✅Globally cached dotnet tool nuget package deleted.";
}

# Find all of the nuget packages and delete them
Remove-Item -Path $packageSourcePath -Force -Recurse -Confirm:$false;
New-Item -Path "./package" -ItemType Directory

# Build source project
dotnet build $projectFilePath

dotnet pack $projectFilePath -c "Debug" -o $nugetOutputPath

# Create the dotnet tool manifest
dotnet new tool-manifest

# Installed the dotnet tool locally
$foundPackage = Get-ChildItem -Path "$packageSourcePath/**/*.nupkg" -Recurse | ForEach-Object{$_.FullName};

$packageFileName = [System.IO.Path]::GetFileNameWithoutExtension($foundPackage);
$packageVersion = "";

# Get the version
$packageVersion = $packageFileName.Split("$packageName.")[1];

dotnet tool install $packageName --add-source $packageSourcePath --version $packageVersion
