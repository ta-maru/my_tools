@echo off

REM 文字化け対策
chcp 932

REM 各種パラメータ
SET USER=SYSTEM
SET PASSWORD=********
SET DUMP_FILE=EXPDAT.DMP
SET CREATE_USER=USER1

pushd %~dp0

echo *** ユーザ初期化開始 ***

sqlplus %USER%/%PASSWORD%@DB_NAME @create_user.sql

echo *** ユーザ初期化終了 ***

REM エラーレベルが1以上の場合、異常終了
if ERRORLEVEL 1 goto :EXCEPTION


echo *** ダンプデータ登録開始 ***

imp %USER%/%PASSWORD%@DB_NAME file='%DUMP_FILE%' fromuser=(%CREATE_USER%) touser=(%CREATE_USER%) ignore=y log=imp.log 2>nul

echo *** ダンプデータ登録終了 ***


REM 正常終了
goto :END

REM 異常終了
:EXCEPTION
echo BAT_ERROR：SQLファイル実行中にエラーが発生したため処理を中断します。（ERRORLEVEL：%ERRORLEVEL%）

:END

popd
pause
