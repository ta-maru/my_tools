@echo off
setlocal ENABLEDELAYEDEXPANSION

chcp 932

cls

set SRV=(local)
set DB=DBName

set time2=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~2,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%
set LOG_FILE=_%TODAY%.log

REM �f�[�^�폜
for %%V in (./tsv/*.tsv) do (

  sqlcmd -S !SRV! -d !DB! -E -Q "DELETE FROM %%~nV" -o "log\del_%%~nV!LOG_FILE!"
  echo �폜���s %%V
)
echo �f�[�^�폜���������܂����B


REM �f�[�^�C���|�[�g
for %%V in (./tsv/*.tsv) do (

  sqlcmd -S !SRV! -d !DB! -E -v CUR_DIR="%~dp0" TABLE_NAME="%%~nV" EXTENSION=".tsv" FIELDTERMINATOR="\t" FORMAT="format\%%~nV.xml" -i .\bulk_insert.sql -o ".\log\imp_%%~nV!LOG_FILE!"
  echo �f�[�^�C���|�[�g���s %%V
)
echo �f�[�^�C���|�[�g���������܂����B
pause
