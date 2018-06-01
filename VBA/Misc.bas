Attribute VB_Name = "Misc"
Option Explicit

Declare Function SHCreateDirectoryEx Lib "shell32" Alias _
                                         "SHCreateDirectoryExA" (ByVal hwnd As Long, ByVal pszPath As String, ByVal psa As Long) As Long

' ファイル操作

' File System Objectの生成
Public Function CreateFSO() As Object

    Set CreateFSO = CreateObject("Scripting.FileSystemObject")

End Function

' ファイル有無チェック
public Function ExistsFile(ByVal fileName As String) As Boolean
    ExistsFile = False

    fileName = GetAbsolutePathName(fileName)

    If (Dir(fileName, vbDirectory) = "") Then

        Exit Function
    End If

    ExistsFile = True

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

' フォルダの文字列を抜き出す
Public Function GetFolderPath(ByVal fullPath As String)

    Dim pos As Long

    pos = InStrRev(fullPath, "\")
    
    GetFolderPath = Left(fullPath, pos)
    
End Function


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

' ハッシュ関数
Public Function ToHash(Password As String) As String
    
    Dim objSHA256 As Variant
    Dim objUTF8   As Variant

    Dim bytes() As Byte
    Dim hash()  As Byte

    Dim i  As Long
    Dim wk As String

    Set objSHA256 = CreateObject("System.Security.Cryptography.SHA256Managed")
    Set objUTF8 = CreateObject("System.Text.UTF8Encoding")

    ' 文字列を UTF8 にエンコードし、バイト配列に変換
    bytes = objUTF8.GetBytes_4(Password)

    ' ハッシュ値を計算（バイナリ）
    hash = objSHA256.ComputeHash_2((bytes))

    ' バイナリを16進数文字列に変換
    For i = 1 To UBound(hash) + 1
        wk = wk & Right("0" & Hex(AscB(MidB(hash, i, 1))), 2)
    Next i

    ' 結果を返す
    ToHash = LCase(wk)

End Function

' .NETのString.Format関数相当
Public Function StringFormat(ByVal msg As String, ByVal arg1 As String) As String

    StringFormat = Replace(msg, "{0}", arg1)

End Function

' .NETのString.Format関数相当（引数2つ）
Public Function StringFormat2(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String) As String

    msg = Replace(msg, "{1}", arg2)
    
    StringFormat2 = StringFormat(msg, arg1)

End Function

' .NETのString.Format関数相当（引数3つ）
Public Function StringFormat3(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String) As String

    msg = Replace(msg, "{2}", arg3)
    
    StringFormat3 = StringFormat2(msg, arg1, arg2)

End Function

' .NETのString.Format関数相当（引数4つ）
Public Function StringFormat4(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String) As String

    msg = Replace(msg, "{3}", arg4)
    
    StringFormat4 = StringFormat3(msg, arg1, arg2, arg3)

End Function

' .NETのString.Format関数相当（引数5つ）
Public Function StringFormat5(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String) As String

    msg = Replace(msg, "{4}", arg5)
    
    StringFormat5 = StringFormat4(msg, arg1, arg2, arg3, arg4)

End Function

' .NETのString.Format関数相当（引数6つ）
Public Function StringFormat6(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String) As String

    msg = Replace(msg, "{5}", arg6)
    
    StringFormat6 = StringFormat5(msg, arg1, arg2, arg3, arg4, arg5)

End Function

' .NETのString.Format関数相当（引数7つ）
Public Function StringFormat7(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String, ByVal arg7 As String) As String

    msg = Replace(msg, "{6}", arg7)
    
    StringFormat7 = StringFormat6(msg, arg1, arg2, arg3, arg4, arg5, arg6)

End Function

' .NETのString.Format関数相当（引数8つ）
Public Function StringFormat8(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String, ByVal arg7 As String, ByVal arg8 As String) As String

    msg = Replace(msg, "{7}", arg8)
    
    StringFormat8 = StringFormat7(msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7)

End Function

' .NETのString.Format関数相当（引数9つ）
Public Function StringFormat9(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String, ByVal arg7 As String, ByVal arg8 As String, ByVal arg9 As String) As String

    msg = Replace(msg, "{8}", arg9)
    
    StringFormat9 = StringFormat8(msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)

End Function

' NULL or Emptyチェック
Public Function IsNullOrEmpty(ByVal str As Variant) As Boolean

    IsNullOrEmpty = False

    If IsNull(str) Or IsEmpty(str) Then IsNullOrEmpty = True
    
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

' 自分のパソコンのコンピュータ名を返す
Public Function GetMyComputerName() As String

  Dim strBuf As String * 21

  ' API関数によってコンピューター名を取得
  GetComputerName strBuf, Len(strBuf)
    
  ' 後続のNullを取り除いて返り値を設定
  GetMyComputerName = Left$(strBuf, InStr(strBuf, vbNullChar) - 1)

End Function

' Windowsのユーザ名を返す
Public Function GetWindowsUserName() As String

    Dim wsObj As Object
    Set wsObj = CreateObject("WScript.Network")

    GetWindowsUserName = wsObj.UserName
    
    Set wsObj = Nothing
    
End Function

' IPアドレス取得（WMIを使用）
Public Function GetIPAddress() As String

    Dim sql As String: sql = "SELECT * FROM Win32_NetworkAdapterConfiguration " & "WHERE (IPEnabled = TRUE)"

    Dim iPAddress    As Variant
    Dim objNic       As Variant
    Dim netAdapters  As Variant: Set netAdapters = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2").ExecQuery(sql)

    For Each objNic In netAdapters
        
        For Each iPAddress In objNic.iPAddress
        
            GetIPAddress = iPAddress
            Exit For
        Next
        Exit For
    Next

End Function

' Guidの生成
Public Function CreateGuidString() As String
    
    Dim guid As GUID_TYPE
    Dim strGuid As String
    Dim retValue As LongPtr
    Const guidLength As Long = 39 'registry GUID format with null terminator {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
 
    retValue = CoCreateGuid(guid)
    
    If retValue = 0 Then
        strGuid = String$(guidLength, vbNullChar)
        retValue = StringFromGUID2(guid, StrPtr(strGuid), guidLength)
        If retValue = guidLength Then ' valid GUID as a string
             CreateGuidString = strGuid
        End If
    End If
    
    CreateGuidString = Replace(CreateGuidString, "{", "")
    CreateGuidString = Replace(CreateGuidString, "}", "")
    CreateGuidString = Replace(CreateGuidString, Chr(10), "")
    CreateGuidString = Replace(CreateGuidString, Chr(13), "")
    CreateGuidString = Left(CreateGuidString, 36)
    
End Function


' TEMP

' HyperLinkクリック時
Private Sub Workbook_SheetBeforeRightClick(ByVal Sh As Object, ByVal Target As Range, Cancel As Boolean)

    If (Sh.Name <> wsList.Name) Then Exit Sub
    If (Target.Column <> 6) Then Exit Sub ' E列

    Cancel = True
    
    ' クリックされたセル
    Dim r As Range: Set r = wsList.Range(Target.Address)
    
    Dim file As String: file = wsList.Range("A1").Offset(r.Row - 1).Value ' フルパス(A列)
    Dim step As Long: step = wsList.Range("B1").Offset(r.Row - 1).Value ' 一致行(E列)
    
    If (file = "") Then Exit Sub
        
    ' テキストエディタで開く
    Call OpenInSakura(wsConfig.Range("B1").Value & "\" & file, step)

End Sub

' テキストエディタで指定ファイルを開く
Private Sub OpenInSakura(ByVal file As String, ByVal step As Long)

    Call Execute("""" & wsConfig.Range("B2").Value & """", """" & file & """", "-Y=" & CStr(step))

End Sub

' EXEファイルの実行
Private Sub Execute(ByVal exe As String, ByVal arg1 As String, ByVal arg2 As String)

    Shell exe & " " & arg1 & " " & arg2, vbNormalFocus

End Sub

