REM CSVファイルが無ければスキップする

IF NOT EXIST csv\%1.csv (

    echo %1.csv が存在しません。
    GOTO END
)

sqlldr userid="%ORA_USER%" log="%LOG%\%1.log" data="%CSV%\%1.csv" bad="%BAD%\1.bad" control="%CTL%\1.ctl"

echo %1 のインポート処理が完了しました。

:END
