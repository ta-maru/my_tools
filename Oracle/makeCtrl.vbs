' 実行方法：# cscript makeCtrl.vbs

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
Function GetCtrlFile(vList)

    Dim str, v

    v = vList(0)

    str = ""
    str = str & "LOAD DATA" & vbCrLf
    str = str & "INFILE 'csv\" & v(0) & ".csv" & vbCrLf
    str = str & "BADFILE 'bad\" & v(0) & ".bad" & vbCrLf
    str = str & "REPLACE" & vbCrLf ' FK貼ってある場合、TRUNCATEだとうまくいかない
    str = str & "INTO TABLE " & v(0) & vbCrLf
    str = str & "FIELDS TERMINATED BY "","" OPTIONALLY ENCLOSED BY '""'" & vbCrLf
    str = str & "TRAILING NULLCOLS" & vbCrLf
    str = str & "(" & vbCrLf
    str = str & GetColumns(vList)
    str = str & ")" & vbCrLf

    GetCtrlFile = str
End Function


' カラムの作成
Function GetColumns(vList)

    Dim str, i, v, optDt

    str = ""

    i = 1

    For Each v In vList

        optDt = ""

        ' 型判定
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

        oPath = GetScriptFolder() & "\ctrl\" & prev & ".ctl"
        Call OutputFile(oPath, GetCtrlFile(tmpList))

        Set tmpList = NewList
        prev = v(0)
    End If

    tmpList.Add(v)
Next

' 最後のテーブル分を出力
oPath = GetScriptFolder() & "\ctrl\" & prev & ".ctl"
Call OutputFile(oPath, GetCtrlFile(tmpList))

WScript.Quit 0
