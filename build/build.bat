SET MSBUILD="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"

%MSBUILD% build-core.proj /target:TeamCityBuild;NuGetPack /property:Configuration=Release;PatchVersion=41
%MSBUILD% build.proj /target:TeamCityBuild;NuGetPack /property:Configuration=Release;PatchVersion=9
%MSBUILD% build-sn.proj /target:NuGetPack /property:Configuration=Signed;PatchVersion=9

CD ..\src\ServiceStack.Admin.Web

COPY GitHubQuery.cs ..\..\tests\TestSelfHost
COPY GitHubQuery.cs ..\..\tests\TestWebHost
COPY StackOverflowQuery.cs ..\..\tests\TestSelfHost
COPY StackOverflowQuery.cs ..\..\tests\TestWebHost
COPY App_Data\db.sqlite ..\..\tests\TestSelfHost
COPY App_Data\db.sqlite ..\..\tests\TestWebHost\App_Data

RMDIR ..\ServiceStack.Admin\ss_admin /s /q
XCOPY /E wwwroot ..\ServiceStack.Admin\ss_admin\