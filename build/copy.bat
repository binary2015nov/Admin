REM SET BUILD=Debug
SET BUILD=Release

COPY ..\src\ServiceStack.Admin\bin\%BUILD%\net45\ServiceStack.Admin.* ..\..\ServiceStack\lib\net45
COPY ..\src\ServiceStack.Admin\bin\%BUILD%\netstandard2.0\ServiceStack.Admin.* ..\..\ServiceStack\lib\netstandard2.0