@echo off

REM ���������΍�
chcp 932

REM �e��p�����[�^
SET USER=SYSTEM
SET PASSWORD=********
SET DUMP_FILE=EXPDAT.DMP
SET CREATE_USER=USER1

pushd %~dp0

echo *** �_���v�f�[�^�o�͊J�n ***

exp %USER%/%PASSWORD%@DB_NAME file='%DUMP_FILE%' owner=(%CREATE_USER%) log=exp.log 2>nul

echo *** �_���v�f�[�^�o�͏I�� ***

popd
pause
