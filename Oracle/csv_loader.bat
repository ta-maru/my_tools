REM CSV�t�@�C����������΃X�L�b�v����

IF NOT EXIST csv\%1.csv (

    echo %1.csv �����݂��܂���B
    GOTO END
)

sqlldr userid="%ORA_USER%" log="%LOG%\%1.log" data="%CSV%\%1.csv" bad="%BAD%\1.bad" control="%CTL%\1.ctl"


REM bad�t�@�C���̗L���Alog�t�@�C����ORA�G���[�̗L���Ő���E�ُ�𔻒�
REM �iload�O��clean�Ɏ��s�����bad�t�@�C������o�͂��Ȃ�����log�t�@�C�����`�F�b�N����j

IF EXIST %BAD%\%1.bad GOTO ERROR_SQLLDR

FINDSTR ORA- "%LOG%\%1.log" > NUL
IF NOT (%ERRORLEVEL% == 0) GOTO ERROR_SQLLDR

echo %1 �̃C���|�[�g�������������܂����B


REM �G���[�̏ꍇ�A�㑱�����͂��Ȃ�
:ERROR_SQLLDR
echo SQLLDR�ŃG���[�������������ߏ����𒆒f���܂��B
pause
exit

:END
