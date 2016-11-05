' ���s���@�F# cscript makeCtrl.vbs

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
Function GetCtrlFile(vList)

    Dim str, v

    v = vList(0)

    str = ""
    str = str & "LOAD DATA" & vbCrLf
    str = str & "INFILE 'csv\" & v(0) & ".csv" & vbCrLf
    str = str & "BADFILE 'bad\" & v(0) & ".bad" & vbCrLf
    str = str & "REPLACE" & vbCrLf ' FK�\���Ă���ꍇ�ATRUNCATE���Ƃ��܂������Ȃ�
    str = str & "INTO TABLE " & v(0) & vbCrLf
    str = str & "FIELDS TERMINATED BY "","" OPTIONALLY ENCLOSED BY '""'" & vbCrLf
    str = str & "TRAILING NULLCOLS" & vbCrLf
    str = str & "(" & vbCrLf
    str = str & GetColumns(vList)
    str = str & ")" & vbCrLf

    GetCtrlFile = str
End Function


' �J�����̍쐬
Function GetColumns(vList)

    Dim str, i, v, optDt

    str = ""

    i = 1

    For Each v In vList

        optDt = ""

        ' �^����
        If (v(3) = "DATE") Then
            optDt = " DATE ""YYYY-MM-DD HH24:MI:SS"""
        End If

        If (v(1) = 1) Then
            str = str & " " & v(1) & optDt & vbCrLf
        Else
            str = str & " ," & v(1) & optDt & vbCrLf
        End
    Next

    GetColumns = str
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

        oPath = GetScriptFolder() & "\ctrl\" & prev & ".ctl"
        Call OutputFile(oPath, GetCtrlFile(tmpList))

        Set tmpList = NewList
        prev = v(0)
    End If

    tmpList.Add(v)
Next

' �Ō�̃e�[�u�������o��
oPath = GetScriptFolder() & "\ctrl\" & prev & ".ctl"
Call OutputFile(oPath, GetCtrlFile(tmpList))

WScript.Quit 0
