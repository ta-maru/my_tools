@echo off
setlocal ENABLEDELAYEDEXPANSION

REM 文字化け対策
chcp 932

REM 各種パラメータ

SET SRV=(local)\SQLExpress
SET DB=SampleDB

SET DIR_LOG=./log
SET DIR_SQL=./sql
REM SET DIR_SQL=./sql/downgrade

REM Windows認証の場合、以下は設定不要
SET USER=
SET PASS=

REM Windows認証用
SET CONN=-E

SET DATETIME=%DATE:~-10,4%%DATE:~-5,2%%DATE:~-2%-%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%


IF "%USER%" NEQ "" (

  REM SQL Server認証用
  SET CONN=-U %USER% -P %PASS%
)


REM DB接続チェック
sqlcmd %CONN% -S %SRV% -d %DB% -b -t 30 -Q "EXIT"

IF %ERRORLEVEL% NEQ 0 (

  ECHO SQL Server接続に失敗しました。（ErrorLevel:%ERRORLEVEL%）
  GOTO EXCEPTION
)


REM SQLファイルの実行
FOR %%i IN (%DIR_SQL%/*.sql) DO (

  sqlcmd !CONN! -S !SRV! -d !DB! -b -i "!DIR_SQL!/%%~ni.sql" -o "!DIR_LOG!/%%~ni_!DATETIME!.log"
  ECHO SQLファイル実行 %%i 
)

:EXCEPTION

PAUSE
