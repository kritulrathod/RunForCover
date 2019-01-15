FOR /F "tokens=*" %%A IN ('type "config.ini"') DO SET %%A
set "AppDrive=%AppDrive_Config%"
set "AppRoot=%AppRoot_Config%"
set "VSTestPath=%VSTestPath_Config%"
set "AppTestDllPath=%AppTestDllPath_Config%"

for /f "tokens=* delims=/" %%A in ('cd') do set CURRENT_DIR=%%A
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"


Cd\
%AppDrive%
Cd "%CURRENT_DIR%\OpenCover.4.5.3522"															
OpenCover.Console.exe -register:user -target:"%VSTestPath%" -targetargs:"%AppTestDllPath%" -output:"%CURRENT_DIR%\OpenCover.4.5.3522\cover\coverage%fullstamp%.xml" 
REM > "%CURRENT_DIR%\OpenCover.4.5.3522\Log\%fullstamp%_log.txt

Cd "%CURRENT_DIR%\ReportGenerator.2.0.4.0\"															
ReportGenerator.exe -reports:"%CURRENT_DIR%\OpenCover.4.5.3522\cover\coverage%fullstamp%.xml" -targetdir:%CURRENT_DIR%\ReportGenerator.2.0.4.0\report\%fullstamp%_report -reporttypes:Html -Verbosity:Verbose
REM > "%CURRENT_DIR%\ReportGenerator.2.0.4.0\Log\%fullstamp%_log.txt

CD ..

start ReportGenerator.2.0.4.0\report\%fullstamp%_report\index.htm
