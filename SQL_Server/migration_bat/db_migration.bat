@echo off
setlocal ENABLEDELAYEDEXPANSION

REM ���������΍�
chcp 932

REM �e��p�����[�^

SET SRV=(local)\SQLExpress
SET DB=SampleDB

SET DIR_LOG=./log
SET DIR_SQL=./sql
REM SET DIR_SQL=./sql/downgrade

REM Windows�F�؂̏ꍇ�A�ȉ��͐ݒ�s�v
SET USER=
SET PASS=

REM Windows�F�ؗp
SET CONN=-E

SET DATETIME=%DATE:~-10,4%%DATE:~-5,2%%DATE:~-2%-%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%


IF "%USER%" NEQ "" (

  REM SQL Server�F�ؗp
  SET CONN=-U %USER% -P %PASS%
)


REM DB�ڑ��`�F�b�N
sqlcmd %CONN% -S %SRV% -d %DB% -b -t 30 -Q "EXIT"

IF %ERRORLEVEL% NEQ 0 (

  ECHO SQL Server�ڑ��Ɏ��s���܂����B�iErrorLevel:%ERRORLEVEL%�j
  GOTO EXCEPTION
)


REM SQL�t�@�C���̎��s
FOR %%i IN (%DIR_SQL%/*.sql) DO (

  sqlcmd !CONN! -S !SRV! -d !DB! -b -i "!DIR_SQL!/%%~ni.sql" -o "!DIR_LOG!/%%~ni_!DATETIME!.log"
  ECHO SQL�t�@�C�����s %%i 
)

:EXCEPTION

PAUSE
