@echo off

REM ���ݒ�
set   SVN_EXE="C:\Program Files\TortoiseSVN\bin\svn.exe"
set BUILD_EXE="C:\Windows\Microsoft.NET\Framework64\v4.030319\MSBuild.exe"

set SLN_DIR="C:\svn\"
set SLN_NAME=test.sln

set WEB_DIR="C:\inetpub\wwwroot\svn\"

set YYYYMMDD=%DATE:/=%

REM ���ꂪ��łȂ���MSBuild�ŃG���[�ɂȂ�
set PLATFORM=


REM �ŐV�\�[�X�擾
%SVN_EXE% update %SLN_DIR%

REM �R�[�h���͎��s
cd %SLN_DIR%
del analyze.txt
echo ���s�����F%date% %time% > analyze.txt
%BUILD_EXE% %SLN_NAME% /p:RunCodeAnalysis=true /t:Rebuild /fl /flp:logfile=analyze.txt;verbosity=m;Append

REM ���ʃR�s�[
copy /Y analyze.txt analyze_%YYYYMMDD%.txt
copy /Y analyze.txt %WEB_DIR%analyze.txt
