cls

Write-Host "Checking NuGet"
  [String] $outputDirectory =$artifacts,
  [String] $configuration =  $Release

#$projects = Get-SolutionProjects
$absoluteOutputDirectory= "$((Get-Location).Path)\$outputDirectory"

#if((Test-Path $absoluteOutputDirectory))
#	{
#		Write-Host "Cleaning artifacts directory $absoluteOutputDirectory"
#		Remove-Item "$absoluteOutputDirectory" -Recurse -Force # -ErrorAction SilentlyContinue | Out-Null
#	}
#	New-Item $absoluteOutputDirectory -ItemType Directory | Out-Null

#	$projects | 
#		ForEach-Object {
#			Write-Host "Cleaning bin and obj folders for $($_.Directory)"
#			Remove-Item "$($_.Directory)\bin" -Recurse -Force # -ErrorAction SilentlyContinue | Out-Null
#			Remove-Item "$($_.Directory)\obj" -Recurse -Force #-ErrorAction SilentlyContinue | Out-Null
#		}
#use "14.0" MSBuild
	$projects |
		ForEach-Object {
			if(!$_.IsWebProject)
			{
				$webOutDir = "$absoluteOutputDirectory\$($_.Name)"
				#$outDir = "$absoluteOutputDirectory\$($_.Name)\bin"
				$outDir = "$absoluteOutputDirectory\$($_.Name)"	;	

				Write-Host "Compiling $($_.Name) to $outDir"
				Write-Host "$webOutDir + '/Todo.Web.sln'"
				#Write-Host  "Path $($.Path)"
				Write-Host "Web project $absoluteOutputDirectory  $webOutDir outdir $outDir "
				 #$buildOptions = '/p:Configuration=Debug /p:Platform="Any CPU" /p:OutDir=$outDir'
				New-Item $absoluteOutputDirectory/out -ItemType Directory | Out-Null
				$buildResult = Invoke-MsBuild -Path "C:\Users\ParupatiK\source\repos\TestJenkinsProject_5132019\TestJenkinsProject_5132019.sln" -BuildLogDirectoryPath PathDirectory   
				#-MsBuildParameters "/property:OutDir=$outDir"
				Remove-Item $absoluteOutputDirectory/out -Force
if ($buildResult.BuildSucceeded -eq $true)
{
	Write-Output ("Build completed successfully in {0:N1} seconds." -f $buildResult.BuildDuration.TotalSeconds)
}
elseif ($buildResult.BuildSucceeded -eq $false)
{
	Write-Output ("Build failed after {0:N1} seconds. Check the build log file '$($buildResult.BuildLogFilePath)' for errors." -f $buildResult.BuildDuration.TotalSeconds)
	Write-Host "$($buildResult.Message)"
}
				#Invoke-MsBuild -Path "C:\Users\ParupatiK\Downloads\dot-net-applications-deployment-pipeline\02\demos\Exercise files\Todo.Web\Todo.Web.sln"  -MsBuildParameters "/target:Clean;Build/property:Configuration=Release;Platform=x64;/property:OutDir=$outDir" -ShowBuildOutputInNewWindow

				
				
				#Write-Host "Compiling $($_.Name) to $webOutDir"
				# Write-Host "Not web project"
				#exec {MSBuild $($_.Path) /p:Configuration=$configuration /p:OutDir=$outDir `
				#					     /nologo /p:DebugType=None /p:Platform=AnyCpu  /verbosity:quiet }
				#/p:Configuration=$configuration /p:OutDir=$outDir`
				#					  /p:DebugType=None /p:Platform=AnyCpu /verbosity:quiet 
				#& {MSBuild $($_.Path) /p:Configuration=$configuration /p:OutDir=$outDir`
				#					 /nologo /p:DebugType=None /p:Platform=AnyCpu /verbosity:quiet }
				}
			}