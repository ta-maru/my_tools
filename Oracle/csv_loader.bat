REM CSVファイルが無ければスキップする

IF NOT EXIST csv\%1.csv (

    echo %1.csv が存在しません。
    GOTO END
)

sqlldr userid="%ORA_USER%" log="%LOG%\%1.log" data="%CSV%\%1.csv" bad="%BAD%\1.bad" control="%CTL%\1.ctl"


REM badファイルの有無、logファイルのORAエラーの有無で正常・異常を判定
REM （load前のcleanに失敗するとbadファイルすら出力しないためlogファイルもチェックする）

IF EXIST %BAD%\%1.bad GOTO ERROR_SQLLDR

FINDSTR ORA- "%LOG%\%1.log" > NUL
IF NOT (%ERRORLEVEL% == 0) GOTO ERROR_SQLLDR

echo %1 のインポート処理が完了しました。


REM エラーの場合、後続処理はしない
:ERROR_SQLLDR
echo SQLLDRでエラーが発生したため処理を中断します。
pause
exit

:END
