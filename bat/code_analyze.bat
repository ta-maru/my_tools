@echo off

REM 環境設定
set   SVN_EXE="C:\Program Files\TortoiseSVN\bin\svn.exe"
set BUILD_EXE="C:\Windows\Microsoft.NET\Framework64\v4.030319\MSBuild.exe"

set SLN_DIR="C:\svn\"
set SLN_NAME=test.sln

set WEB_DIR="C:\inetpub\wwwroot\svn\"

set YYYYMMDD=%DATE:/=%

REM これが空でないとMSBuildでエラーになる
set PLATFORM=


REM 最新ソース取得
%SVN_EXE% update %SLN_DIR%

REM コード分析実行
cd %SLN_DIR%
del analyze.txt
echo 実行日時：%date% %time% > analyze.txt
%BUILD_EXE% %SLN_NAME% /p:RunCodeAnalysis=true /t:Rebuild /fl /flp:logfile=analyze.txt;verbosity=m;Append

REM 結果コピー
copy /Y analyze.txt analyze_%YYYYMMDD%.txt
copy /Y analyze.txt %WEB_DIR%analyze.txt
