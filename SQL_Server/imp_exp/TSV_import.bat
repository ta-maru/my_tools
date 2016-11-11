@echo off
setlocal ENABLEDELAYEDEXPANSION

chcp 932

cls

set SRV=(local)
set DB=DBName

set time2=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~2,2%-%time2:~0,2%%time2:~3,2%%time2:~6,2%
set LOG_FILE=_%TODAY%.log

REM データ削除
for %%V in (./tsv/*.tsv) do (

  sqlcmd -S !SRV! -d !DB! -E -Q "DELETE FROM %%~nV" -o "log\del_%%~nV!LOG_FILE!"
  echo 削除実行 %%V
)
echo データ削除が完了しました。


REM データインポート
for %%V in (./tsv/*.tsv) do (

  sqlcmd -S !SRV! -d !DB! -E -v CUR_DIR="%~dp0" TABLE_NAME="%%~nV" EXTENSION=".tsv" FIELDTERMINATOR="\t" FORMAT="format\%%~nV.xml" -i .\bulk_insert.sql -o ".\log\imp_%%~nV!LOG_FILE!"
  echo データインポート実行 %%V
)
echo データインポートが完了しました。
pause
