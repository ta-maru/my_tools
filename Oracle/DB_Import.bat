@echo off

REM ���������΍�
chcp 932

REM �e��p�����[�^
SET USER=SYSTEM
SET PASSWORD=********
SET DUMP_FILE=EXPDAT.DMP
SET CREATE_USER=USER1

pushd %~dp0

echo *** ���[�U�������J�n ***

sqlplus %USER%/%PASSWORD%@DB_NAME @create_user.sql

echo *** ���[�U�������I�� ***

REM �G���[���x����1�ȏ�̏ꍇ�A�ُ�I��
if ERRORLEVEL 1 goto :EXCEPTION


echo *** �_���v�f�[�^�o�^�J�n ***

imp %USER%/%PASSWORD%@DB_NAME file='%DUMP_FILE%' fromuser=(%CREATE_USER%) touser=(%CREATE_USER%) ignore=y log=imp.log 2>nul

echo *** �_���v�f�[�^�o�^�I�� ***


REM ����I��
goto :END

REM �ُ�I��
:EXCEPTION
echo BAT_ERROR�FSQL�t�@�C�����s���ɃG���[�������������ߏ����𒆒f���܂��B�iERRORLEVEL�F%ERRORLEVEL%�j

:END

popd
pause
