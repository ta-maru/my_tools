' ���s���@�F# cscript makeSQL.vbs

Option Explicit

' List�C���X�^���X�쐬
Function NewList()

    Set NewList = CreateObject("System.Collections.ArrayList")
End Function


' �X�N���v�g�̃t�H���_�̎擾
Function GetScriptFolder()

    Dim scriptPath, fso

    scriptPath = Wscript.ScriptFullName

    Set fso = CreateObject("Scripting.FileSystemObject")

    GetScriptFolder = fso.GetParentFolderName(scriptPath)
End Function


' CSV�t�@�C���ǂݍ��݁i�񎟌��z��iaryRows(x)(y)�ɓǂݍ��ށj
Function ReadCSV(path)

    Dim fso, strText, lines, lineCnt, aryRows, i

    Set fso = CreateObject("Scripting.FileSystemObject")

    strText = fso.OpenTextFile(path, 1).ReadAll

    lines = Split(strText, vbCrLf)

    lineCnt = UBound(lines)

    Redim aryRows(lineCnt - 1) ' vbs�̔z��̓[���X�^�[�g

    For i = 0 To (lineCnt - 1)

        aryRows(i) = Split(lines(i), ",")
    Next

    ReadCSV = aryRows
End Function


' �t�@�C���o��
Sub OutputFile(path, text)

    Dim fso, fo

    Set fso = CreateObject("Scripting, FileSystemObject")

    Set fo = fso.OpenTextFile(path, 2, true)

    fo.Write text
    fo.Close
End Sub


' �t�@�C���̓��e���擾
Function GetSQLFile(vList)

    Dim str

    str = ""
    str = str & "set echo off" & vbCrLf
    str = str & "set pagesize 0" & vbCrLf
    str = str & "set term off" & vbCrLf
    str = str & "set trimspool on" & vbCrLf
    str = str & "set newpage none" & vbCrLf
    str = str & "set heading off" & vbCrLf
    str = str & "set feedback off" & vbCrLf
    str = str & "set verify off" & vbCrLf
    str = str & "set linesize 5000" & vbCrLf
    str = str & "ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS'" & vbCrLf
    str = str & "/" & vbCrLf
    str = str & "csv\" & vList(0) & ".csv" & vbCrLf
    str = str & GetSelectSQL(vList)
    str = str & "/" & vbCrLf
    str = str & "spool off" & vbCrLf

    GetSQLFile = str
End Function


' SELECT���̍쐬
Function GetSelectSQL(vList)

    Dim str, i, v, strOBy

    str = "SELECT" & vbCrLf
    strOBy = ""

    i = 1

    For Each v In vList

        ' �^����iCHAR�^�Ŕ�NULL�̏ꍇ�A�_�u���N�H�e�[�V�����ň͂ށA���̑��͈͂܂Ȃ��B�������ALONG�^�̏ꍇ�A�����񌋍��s�̂��߉������Ȃ�

        If ((v(3) = "VARCHAR2") Or (v(3) = "CHAR")) Then
            tmpItem = "NVL2(" & v(1) & ", " & "'""' || " & v(1) & " || '""'" & ", " & v(1) & " )"
        ElseIf (v(3) <> "LONG") Then
            tmpItem = v(1)
        End If

        If (v(2) = 1) Then
            str = str & tmpItem
        Else
            str = str & "|| ',' || " & tmpItem
        End If

        ' Order By��̍쐬
        If (v(4) <> "") Then
            If (strOBy = "") Then
                strOBy = v(1)
            Else
                strOBy = strOBy & ", " & v(1)
            End If
        End If
    Next

    if (strOBy = "") Then strOBy = "1"

    str = str & "FROM " & vList(0)(0) & vbCrLf
    str = str & "ORDER BY " & strOBy & vbCrLf

    GetSelectSQL = str
End Function

' -- ���C������ ---------------------------------------------------------------

' CSV�ǂݍ���
Dim csvPath

csvPath = GetScriptFolder() & "\tables_def.csv"

Dim vList, v, tmpList, prev

vList = ReadCSV(csvPath) ' �z��̗v�f => 0:�e�[�u�����A1:�J�������A2:�J�����ԍ��A3:�f�[�^�^�A4:PK�^

Set tmpList = NewList
prev = vList(0)(0)

' �t�@�C���o��
Dim oPath

For Each v In vList

    If (prev <> v(0)) Then

        oPath = GetScriptFolder() & "\sql\" & prev & ".sql"
        Call OutputFile(oPath, GetSQLFile(tmpList))

        Set tmpList = NewList
        prev = v(0)
    End If

    tmpList.Add(v)
Next

' �Ō�̃e�[�u�������o��
oPath = GetScriptFolder() & "\sql\" & prev & ".sql"
Call OutputFile(oPath, GetSQLFile(tmpList))

WScript.Quit 0
