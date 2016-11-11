' ���s���@�F# cscript makeFormatXML.vbs

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

    Set fso = CreateObject("Scripting.FileSystemObject")

    Set fo = fso.OpenTextFile(path, 2, true)

    fo.Write text
    fo.Close
End Sub


' �t�H�[�}�b�g�t�@�C���̓��e���擾
Function GetXML(vList)

    Dim str

    str = "<?xml version=""1.0""?>" & vbCrLf
    str = str + "<BCPFORMAT xmlns=""http://schemas.microsoft.com/sqlserver/2004/bulkload/format"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">" & vbCrLf
    str = str + GetRecordTag(vList)
    str = str + GetRowTag(vList)
    str = str + "</BCPFORMAT>" & vbCrLf

    GetXML = str
End Function


' �t�H�[�}�b�g�t�@�C����RECORD�^�O���̍쐬
Function GetRecordTag(vList)

    Dim str, i, v

    str = "    <RECORD>" & vbCrLf

    i = 1

    For Each v In vList

        If (i <> vList.Count) Then
            str = str & "        <FIELD ID=""" & i & """ xsi:type=""CharTerm"" TERMINATOR=""\t"" />" & vbCrLf
        Else
            str = str & "        <FIELD ID=""" & i & """ xsi:type=""CharTerm"" TERMINATOR=""\r\n"" />" & vbCrLf
        End If

        i = i + 1
    Next

    GetRecordTag = str & "    </RECORD>" & vbCrLf
End Function


' �t�H�[�}�b�g�t�@�C����ROW�^�O���̍쐬
Function GetRowTag(vList)

    Dim str, i, v

    str = "    <ROW>" & vbCrLf

    i = 1

    For Each v In vList

        If (v(3) = "float") Then
            str = str & "        <COLUMN SOURCE=""" & i & """ NAME=""" & v(1) & """ xsi:type=""SQLFLT8"" />" & vbCrLf
        ElseIf (v(3) = "varchar") Then
            str = str & "        <COLUMN SOURCE=""" & i & """ NAME=""" & v(1) & """ xsi:type=""SQLVARYCHAR"" />" & vbCrLf
        Else
            str = str & "        <COLUMN SOURCE=""" & i & """ NAME=""" & v(1) & """ xsi:type=""SQL" & UCase(v(3)) & """ />" & vbCrLf
        End If

        i = i + 1
    Next

    GetRowTag = str & "    </ROW>" & vbCrLf
End Function

' DebugPrint
' WScript.StdOut.WriteLine "TEST"
' WScript.Echo "TEST"
' MsgBox("TEST")


' -- ���C������ ---------------------------------------------------------------

' CSV�ǂݍ���
Dim csvPath

csvPath = GetScriptFolder() & "\table_def.csv"

Dim vList, v, tmpList, prev

vList = ReadCSV(csvPath) ' �z��̗v�f => 0:�e�[�u�����A1:�J�������A2:�J�����ԍ��A3:�f�[�^�^

Set tmpList = NewList
prev = vList(0)(0)

' �t�H�[�}�b�g�t�@�C���o��
Dim oPath

For Each v In vList

    If (prev <> v(0)) Then

        oPath = GetScriptFolder() & "\format\" & prev & ".xml"
        Call OutputFile(oPath, GetXML(tmpList))

        Set tmpList = NewList
        prev = v(0)
    End If

    tmpList.Add(v)
Next

' �Ō�̃e�[�u�������o��
oPath = GetScriptFolder() & "\format\" & prev & ".xml"
Call OutputFile(oPath, GetXML(tmpList))

WScript.Quit 0
