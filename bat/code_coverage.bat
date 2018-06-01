@ECHO off


REM 環境設定
REM SET BUILD_EXE="C:\Windows\Microsoft.NET\Framework64\v4.030319\MSBuild.exe"
REM SET UT_EXE="C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\mstest.exe"
SET BUILD_EXE="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
SET UT_EXE="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\MSTest.exe"
SET OP_COVER_EXE=".\opencover.4.6.519\OpenCover.Console.exe"
SET REPO_GEN_EXE=".\ReportGenerator_3.0.2.0\ReportGenerator.exe"

SET SLN_FPATH=..\..\temp\temp.sln
SET SLN_DIR=..\..\temp

SET UT_TARGET=C:\temp\MSTest\bin\x86\Debug\MSTest.dll

SET RESULT_OP_TRX=.\JGBManager_UT_Result.trx
SET RESULT_OP_XML=.\JGBManager_UT_Result.xml
SET RESULT_OP_TXT=.\JGBManager_UT_Result.txt
SET RESULT_RP=.\_Report\

SET FILTER=
SET FILTER=%FILTER% +[*]* -[MSTest]* -[*]*.My.*


ECHO カバレッジ・レポート作成 開始

ECHO [1/5] 残骸ファイルの削除

RD /s /q %RESULT_RP%
MKDIR %RESULT_RP%


ECHO [2/5] Build Clean 実行

%BUILD_EXE% %SLN_FPATH% /Clean


ECHO [3/5] Build 実行

%BUILD_EXE% %SLN_FPATH% /Build "Debug|x86"


ECHO [4/5] OpenCover実行

DEL ..\%RESULT_OP_TRX%

%OP_COVER_EXE% -register:user -target:%UT_EXE% -targetargs:"/testcontainer:%UT_TARGET% /resultsfile:%RESULT_OP_TRX%" -filter:"%FILTER%" -mergebyhash -output:%RESULT_OP_XML% -targetdir:"%SLN_DIR%" 1> %RESULT_OP_TXT%


ECHO [5/5] ReportGenerator実行

%REPO_GEN_EXE% -reports:"%RESULT_OP_XML%" -targetdir:"%RESULT_RP%"

ECHO 完了（./_Reportフォルダを参照）

PAUSE
