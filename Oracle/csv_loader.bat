REM CSV�t�@�C����������΃X�L�b�v����

IF NOT EXIST csv\%1.csv (

    echo %1.csv �����݂��܂���B
    GOTO END
)

sqlldr userid="%ORA_USER%" log="%LOG%\%1.log" data="%CSV%\%1.csv" bad="%BAD%\1.bad" control="%CTL%\1.ctl"

echo %1 �̃C���|�[�g�������������܂����B

:END
