' 実行方法：# cscript makeSQL.vbs

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

    Set fso = CreateObject("Scripting, FileSystemObject")

    Set fo = fso.OpenTextFile(path, 2, true)

    fo.Write text
    fo.Close
End Sub


' ファイルの内容を取得
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


' SELECT文の作成
Function GetSelectSQL(vList)

    Dim str, i, v, strOBy

    str = "SELECT" & vbCrLf
    strOBy = ""

    i = 1

    For Each v In vList

        ' 型判定（CHAR型で非NULLの場合、ダブルクォテーションで囲む、その他は囲まない。ただし、LONG型の場合、文字列結合不可のため何もしない

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

        ' Order By句の作成
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

' -- メイン処理 ---------------------------------------------------------------

' CSV読み込み
Dim csvPath

csvPath = GetScriptFolder() & "\tables_def.csv"

Dim vList, v, tmpList, prev

vList = ReadCSV(csvPath) ' 配列の要素 => 0:テーブル名、1:カラム名、2:カラム番号、3:データ型、4:PK型

Set tmpList = NewList
prev = vList(0)(0)

' ファイル出力
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

' 最後のテーブル分を出力
oPath = GetScriptFolder() & "\sql\" & prev & ".sql"
Call OutputFile(oPath, GetSQLFile(tmpList))

WScript.Quit 0
