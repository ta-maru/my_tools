chcp 932

set SRV=ServerName
set DB=DBName
set DATA=tsv
set USER=user1
set PASS=********


bcp tableA format nul -c -t \t -x -f ./format/tableA.xml -S %SRV% -d %DB% -U %USER% -P %PASS%
bcp tableB format nul -c -t \t -x -f ./format/tableB.xml -S %SRV% -d %DB% -U %USER% -P %PASS%
bcp tableC format nul -c -t \t -x -f ./format/tableC.xml -S %SRV% -d %DB% -U %USER% -P %PASS%
bcp tableD format nul -c -t \t -x -f ./format/tableD.xml -S %SRV% -d %DB% -U %USER% -P %PASS%
bcp tableE format nul -c -t \t -x -f ./format/tableE.xml -S %SRV% -d %DB% -U %USER% -P %PASS%

pause
