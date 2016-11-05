@echo off
chcp 932

push %~dp0

SET USER=USER1
SET PASSWORD=********
SET DATABASE=DB1

sqlplus %USER%/%PASSWORD%@%DATABASE% @csv_export_all.sql

popd
pause
