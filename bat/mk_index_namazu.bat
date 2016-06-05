@echo off

REM 環境設定
set LANG=ja_JP.SJIS

set            HOME=C:/tools/namazu/namazu
set  ITAIJIDICTPATH=C:/tools/namazu/kakasi/share/kakasi/itaijidict
set   KANWADICTPATH=C:/tools/namazu/kakasi/share/kakasi/kanwadict
set         MKNMZRC=C:/tools/namazu/namazu/etc/namazu/mknmzrc
set NAMAZULOCALEDIR=C:/tools/namazu/namazu/share/locale
set        NAMAZURC=C:/tools/namazu/namazu/etc/namazu/namazurc

set pkgdatadir=C:/tools/namazu/namazu/share/namazu
set NAMAZU_EXE=C:/tools/namazu/namazu/bin/mknmz.exe

set IDX_DIR="C:\svn\index\
set SLN_DIR="C:\svn\"
set SLN_NAME=test.sln

set YYYYMMDD=%DATE:/=%


REM 最新ソース取得
%SVN_EXE% update %SLN_DIR%

REM インデックスの構築
%NAMAZU_EXE% -U -O %IDX_DIR% %SLN_DIR%
