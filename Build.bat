FOR /F "tokens=*" %%A IN ('type "config.ini"') DO SET %%A
set "AppDrive=%AppDrive_Config%"
set "AppRoot=%AppRoot_Config%"
set "VSTestPath=%VSTestPath_Config%"
set "AppTestDllPath=%AppTestDllPath_Config%"

set "CodeCoverage=%CodeCoverage_Config%"

for /f "tokens=* delims=/" %%A in ('cd') do set CURRENT_DIR=%%A
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

%AppDrive%
CD %CodeCoverage%

REM RMDIR /S/Q .\Report\
REM MKDIR .\Report\
DEL /F/Q/S .\Report\*.* > NUL

MKDIR .\RunForCover\ReportGenerator.2.0.4.0\report\

REM "%CodeCoverage%\RunForCover\OpenCover.4.5.3522\OpenCover.Console.exe" -register:user -target:"%VSTestPath%" -targetargs:".\..\Probench\ProbenchTests\bin\Debug\ProbenchTests.dll /TESTS:PRISectionSubmissionFeature_Config_CT" -output:"%CodeCoverage%\RunForCover\OpenCover.4.5.3522\cover\coverage%fullstamp%.xml"

REM Run Tests
"%CodeCoverage%\RunForCover\OpenCover.4.5.3522\OpenCover.Console.exe" -register:user -target:"%VSTestPath%" -targetargs:".\..\Probench\ProbenchTests\bin\Debug\ProbenchTests.dll" -output:"%CodeCoverage%\RunForCover\OpenCover.4.5.3522\cover\coverage%fullstamp%.xml"

REM Generat Report
"%CodeCoverage%\RunForCover\ReportGenerator.2.0.4.0\ReportGenerator.exe" -reports:"%CodeCoverage%\RunForCover\OpenCover.4.5.3522\cover\coverage%fullstamp%.xml" -targetdir:"%CodeCoverage%\RunForCover\ReportGenerator.2.0.4.0\report\%fullstamp%_report" -reporttypes:Html -Verbosity:Verbose > NUL

XCOPY /S/Y runForCover\ReportGenerator.2.0.4.0\report\%fullstamp%_report .\Report > NUL
XCOPY /S/Y runForCover\ReportGenerator.2.0.4.0\report .\Archieve > NUL

RMDIR /S/Q RunForCover\ReportGenerator.2.0.4.0\report\
REM RMDIR /S/Q .\Report\
