chcp 932

set SRV=ServerName
set DB=DBname
set DATA=tsv
set USER=user1
set PASS=********


bcp TableA out .\%DATA%\TableA.tsv -c -t "\t" -r "\n" -S %SRV% -d %DB% -U %USER% -P %PASS%
bcp TableB out .\%DATA%\TableB.tsv -c -t "\t" -r "\n" -S %SRV% -d %DB% -U %USER% -P %PASS%
bcp TableC out .\%DATA%\TableC.tsv -c -t "\t" -r "\n" -S %SRV% -d %DB% -U %USER% -P %PASS%

pause
