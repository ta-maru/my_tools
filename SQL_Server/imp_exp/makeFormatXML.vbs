' 実行方法：# cscript makeFormatXML.vbs

Option Explicit

' Listインスタンス作成
Function NewList()

    Set NewList = CreateObject("System.Collections.ArrayList")
End Function


' スクリプトのフォルダの取得
Function GetScriptFolder()

    Dim scriptPath, fso

    scriptPath = Wscript.ScriptFullName

    Set fso = CreateObject("Scripting.FileSystemObject")

    GetScriptFolder = fso.GetParentFolderName(scriptPath)
End Function


' CSVファイル読み込み（二次元配列（aryRows(x)(y)に読み込む）
Function ReadCSV(path)

    Dim fso, strText, lines, lineCnt, aryRows, i

    Set fso = CreateObject("Scripting.FileSystemObject")

    strText = fso.OpenTextFile(path, 1).ReadAll

    lines = Split(strText, vbCrLf)

    lineCnt = UBound(lines)

    Redim aryRows(lineCnt - 1) ' vbsの配列はゼロスタート

    For i = 0 To (lineCnt - 1)

        aryRows(i) = Split(lines(i), ",")
    Next

    ReadCSV = aryRows
End Function


' ファイル出力
Sub OutputFile(path, text)

    Dim fso, fo

    Set fso = CreateObject("Scripting.FileSystemObject")

    Set fo = fso.OpenTextFile(path, 2, true)

    fo.Write text
    fo.Close
End Sub


' フォーマットファイルの内容を取得
Function GetXML(vList)

    Dim str

    str = "<?xml version=""1.0""?>" & vbCrLf
    str = str + "<BCPFORMAT xmlns=""http://schemas.microsoft.com/sqlserver/2004/bulkload/format"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">" & vbCrLf
    str = str + GetRecordTag(vList)
    str = str + GetRowTag(vList)
    str = str + "</BCPFORMAT>" & vbCrLf

    GetXML = str
End Function


' フォーマットファイルのRECORDタグ部の作成
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


' フォーマットファイルのROWタグ部の作成
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


' -- メイン処理 ---------------------------------------------------------------

' CSV読み込み
Dim csvPath

csvPath = GetScriptFolder() & "\table_def.csv"

Dim vList, v, tmpList, prev

vList = ReadCSV(csvPath) ' 配列の要素 => 0:テーブル名、1:カラム名、2:カラム番号、3:データ型

Set tmpList = NewList
prev = vList(0)(0)

' フォーマットファイル出力
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

' 最後のテーブル分を出力
oPath = GetScriptFolder() & "\format\" & prev & ".xml"
Call OutputFile(oPath, GetXML(tmpList))

WScript.Quit 0
