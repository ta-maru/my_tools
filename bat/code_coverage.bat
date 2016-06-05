@echo off

REM 環境設定
set OP_COVER_EXE="C:\tools\OpenCover\OpenCover.Console.exe"
set REPO_GEN_EXE="C:\tools\ReportGenerator\ReportGenerator.exe"
set    BUILD_EXE="C:\Windows\Microsoft.NET\Framework64\v4.030319\MSBuild.exe"
set       UT_EXE="C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\mstest.exe"

set  UT_DIR="C:\svn\Prj.Tests\"
set SLN_DIR="C:\svn\"
set SLN_NAME=test.sln

set WEB_DIR="C:\inetpub\wwwroot\svn\"

set YYYYMMDD=%DATE:/=%


REM 各種ファイル削除
del build.txt
del Prj.Tests\Prj.trx

REM 最新ソース取得
%SVN_EXE% update %SLN_DIR%

REM ビルド実行
cd %SLN_DIR%
echo 実行日時：%date% %time% > build.txt
%BUILD_EXE% %SLN_NAME% /t:Rebuild /fl /flp:logfile=analyze.txt;verbosity=m;Append

REM UT実行・カバレッジ測定
%OP_COVER_EXE% -register:user -target:%UT_EXE% -targetargs:"/runconfig:Prj.Tests\Prj.testsettings /usestderr / testcontainer:Prj.Tests\bin\Debug\Prj.Tests.dll /resultsfile:Prj.Tests\Prj.trx" -filter:"+[Prj]* +[Prj.Console]*" -mergebyhash -output:Prj.Tests\Report.xml -targetdir:%SLN_DIR% 1> TestResult.txt

REM カバレッジレポート作成
%REPO_GEN_EXE% "Prj.Tests\Report.xml" "%SLN_DIR%UT_Result"

REM 結果コピー
copy /Y TestResult.txt    TestResult_%YYYYMMDD%.txt
copy /Y build.txt         %WEB_DIR%build.txt
copy /Y TestResult.txt    %WEB_DIR%TestResult.txt
copy /Y Prj.Tests\Prj.trx %WEB_DIR%TestResultDetail.txt

REM テストの残骸の削除
for /F "delims=# eol=#" %%a in ('dir /x /AD /B /W %UT_DIR%UserName_*') do rmdir /S /Q "%UT_DIR%%%a
