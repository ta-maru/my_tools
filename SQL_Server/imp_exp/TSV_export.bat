chcp 932

set SRV=127.0.0.1\\SQLEXPRESS, 1433
set DB=test
set DATA=tsv

bcp TableA out ".\%DATA%\TableA.tsv" -c -t "\t" -r "n" -S %SRV% -d %DB% -U "sa" -P "1234"
bcp TableB out ".\%DATA%\TableB.tsv" -c -t "\t" -r "n" -S %SRV% -d %DB% -U "sa" -P "1234"
bcp TableC out ".\%DATA%\TableC.tsv" -c -t "\t" -r "n" -S %SRV% -d %DB% -U "sa" -P "1234"

pause
