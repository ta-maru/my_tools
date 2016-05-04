@echo off
chcp 932
cd /d %~dp0
cls

set SRV=localhost
set INS=SQLEXPRESS
set DB=test

set time2=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~2,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%
set LOG_FILE=_%TODAY%.log

REM �f�[�^�폜
for %%V in (.\tsv\*.tsv) do

  sqlcmd -S %SRV%\%INS% -d %DB% -E -Q "DELETE FROM %%~nV" -o "log\del_%%~nV%LOG_FILE%"
)
echo �f�[�^�폜���������܂����B


REM �f�[�^�C���|�[�g
for %%V in (.\tsv\*.tsv) do

  sqlcmd -S %SRV%\%INS% -d %DB% -E -v CURRENT_DIR=%~dp0" TABLE_NAME="%%~nV" EXTENSION=".tsv" FIELDTERMINATOR="\t" FORMAT="format\%%~nV.xml" -i %CURRENT_DIR%import.sql -o "log\imp_%%~nV%LOG_FILE%"
)
echo �f�[�^�C���|�[�g���������܂����B
