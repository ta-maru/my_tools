@echo off

REM 文字化け対策
chcp 932

REM 各種パラメータ
SET USER=SYSTEM
SET PASSWORD=********
SET DUMP_FILE=EXPDAT.DMP
SET CREATE_USER=USER1

pushd %~dp0

echo *** ダンプデータ出力開始 ***

exp %USER%/%PASSWORD%@DB_NAME file='%DUMP_FILE%' owner=(%CREATE_USER%) log=exp.log 2>nul

echo *** ダンプデータ出力終了 ***

popd
pause
