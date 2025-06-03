cd UniverseLib
.\build.ps1
cd ..

# ----------- MelonLoader IL2CPP CoreCLR (net6) -----------
dotnet build src/CinematicUnityExplorer.sln -c Release_ML_Cpp_CoreCLR
$Path = "Release\CinematicUnityExplorer.MelonLoader.IL2CPP.CoreCLR"
# ILRepack
lib/ILRepack.exe /target:library /lib:lib/net6 /lib:lib/interop /lib:$Path /internalize /out:$Path/CinematicUnityExplorer.ML.IL2CPP.CoreCLR.dll $Path/CinematicUnityExplorer.ML.IL2CPP.CoreCLR.dll $Path/mcs.dll
# (cleanup and move files)
Remove-Item $Path/CinematicUnityExplorer.ML.IL2CPP.CoreCLR.deps.json
Remove-Item $Path/Tomlet.dll
Remove-Item $Path/mcs.dll
Remove-Item $Path/Iced.dll
Remove-Item $Path/Il2CppInterop.Common.dll
Remove-Item $Path/Il2CppInterop.Runtime.dll
Remove-Item $Path/Microsoft.Extensions.Logging.Abstractions.dll
New-Item -Path "$Path" -Name "Mods" -ItemType "directory" -Force
Move-Item -Path $Path/CinematicUnityExplorer.ML.IL2CPP.CoreCLR.dll -Destination $Path/Mods -Force
New-Item -Path "$Path" -Name "UserLibs" -ItemType "directory" -Force
Move-Item -Path $Path/UniverseLib.ML.IL2CPP.Interop.dll -Destination $Path/UserLibs -Force
# (create zip archive)
Remove-Item $Path/../CinematicUnityExplorer.MelonLoader.IL2CPP.CoreCLR.zip -ErrorAction SilentlyContinue
compress-archive .\$Path\* $Path/../CinematicUnityExplorer.MelonLoader.IL2CPP.CoreCLR.zip
