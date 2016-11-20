Attribute VB_Name = "Misc"
Option Explicit

Declare Function SHCreateDirectoryEx Lib "shell32" Alias _
                                         "SHCreateDirectoryExA" (ByVal hwnd As Long, ByVal pszPath As String, ByVal psa As Long) As Long

' ファイル操作

' File System Objectの生成
Public Function CreateFSO() As Object

    Set CreateFSO = CreateObject("Scripting.FileSystemObject")

End Function

' 絶対パスの取得
Public Function GetAbsolutePathName(ByVal fileName As String) As String

    GetAbsolutePathName = ""
    
    If (fileName = "") Then Exit Function
    
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    GetAbsolutePathName = fso.GetAbsolutePathName(fileName)
End Function

' 絶対パスからファイル名を取得
Public Function GetFileName(ByVal path As String) As String

    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    GetFileName = fso.GetFileName(path)
End Function

' フォルダ作成
Public Sub Mkdir(ByVal path As String)

    Dim rc As Variant
    
    With CreateObject("Scripting.FileSystemObject")
    
        If Not (.FolderExists(path)) Then
        
            rc = SHCreateDirectoryEx(0&, path, 0&)
        
        End If
        
    End With

End Sub

' ファイル選択
Public Function ShowFileOpenDialog() As String

    ShowFileOpenDialog = Application.GetOpenFilename("Microsoft Excelブック, *.xlsx;*xls")
    
End Function

' 指定されたブックに指定されたシートが存在するかを判定
Public Function ExistsReadWs(ByVal wb As Workbook, ByVal readSheet As String) As Boolean

    ExistsReadWs = True
    
    ' 指定されたシートが存在するかを判定
    Dim ws As Worksheet
    
    For Each ws In wb.Worksheets
    
        If (ws.Name = readSheet) Then Exit Function
    
    Next ws
    
    ExistsReadWs = False

End Function

' ツールのあるフォルダへ移動
Public Sub ChangeDir()

    ChDrive ThisWorkbook.path
    ChDir ThisWorkbook.path
End Sub


' 文字列操作

' C言語のコメント文にする
Public Function ConvCLangComment(ByVal str As String) As String

    ConvCLangComment = "/* " & str & " */"

End Function

' シングルクォテーションで囲む
Public Function EnclosedInSQs(ByVal str As String) As String

    EnclosedInSQs = "`" & str & "`"

End Function

' Null文字判定
Public Function IsNullStr(ByVal str As String) As Boolean

    IsNullStr = False
    
    If (str = "NULL") Or (str = "Null") Or (str = "null") Then IsNullStr = True
    
End Function

' 半角文字数を返す
Public Function LenSByteChars(ByVal str As String) As Long

    LenSByteChars = LenB(StrConv(str, vbFromUnicode))

End Function


' ワークシート操作

' 指定シートのA列の内容をテキストファイル出力する
Public Sub WriteToTextFile(ByRef ws As Worksheet, ByVal fName As String)

    Dim fso As Object
    Dim ts As Object
    
    Dim strRec As String
    Dim lineCnt As Long
    Dim lineMax As Long
    
    Set fso = CreateFSO()
    
    ' 最終行の取得
    lineMax = ws.Range("A65533").End(xlUp).Row
    
    Set ts = fso.CreateTextFile(fileName:=ThisWorkbook.path & fName, Overwrite:=True)
    
    lineCnt = 1
    
    Do Until (lineCnt > lineMax)
    
        strRec = ws.Cells(lineCnt, 1).Value
        
        ts.WriteLine strRec
        
        lineCnt = lineCnt + 1
    Loop
    
    ts.Close
    
    Set ts = Nothing
    Set fso = Nothing

End Sub


' その他

' コレクションを結合する
Public Function JoinCollection(ByVal c1 As Collection, ByVal c2 As Collection) As Collection

    Dim v As Variant
    
    For Each v In c2
    
        c1.Add (v)
        
    Next v
    
    Set JoinCollection = c1

End Function
