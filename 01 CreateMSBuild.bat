set MSBuildEmitSolution=1
msbuild <YourSolution>.sln
REM Now Rename the output to "MSBuild.csproj"
REM Then Update the "RunForCover\Config.ini" with proper details for your project & environment