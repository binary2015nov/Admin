REM SET BUILD=Debug
SET BUILD=Release

COPY ..\src\ServiceStack.Admin\bin\%BUILD%\net45\ServiceStack.Admin.* ..\..\ServiceStack\lib\net45
COPY ..\src\ServiceStack.Admin\bin\%BUILD%\netstandard1.6\ServiceStack.Admin.* ..\..\ServiceStack\lib\netstandard1.6

pause
