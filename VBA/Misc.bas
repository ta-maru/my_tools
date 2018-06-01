Attribute VB_Name = "Misc"
Option Explicit

Declare Function SHCreateDirectoryEx Lib "shell32" Alias _
                                         "SHCreateDirectoryExA" (ByVal hwnd As Long, ByVal pszPath As String, ByVal psa As Long) As Long

' �t�@�C������

' File System Object�̐���
Public Function CreateFSO() As Object

    Set CreateFSO = CreateObject("Scripting.FileSystemObject")

End Function

' �t�@�C���L���`�F�b�N
public Function ExistsFile(ByVal fileName As String) As Boolean
    ExistsFile = False

    fileName = GetAbsolutePathName(fileName)

    If (Dir(fileName, vbDirectory) = "") Then

        Exit Function
    End If

    ExistsFile = True

End Function

' ��΃p�X�̎擾
Public Function GetAbsolutePathName(ByVal fileName As String) As String

    GetAbsolutePathName = ""
    
    If (fileName = "") Then Exit Function
    
    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    GetAbsolutePathName = fso.GetAbsolutePathName(fileName)
End Function

' ��΃p�X����t�@�C�������擾
Public Function GetFileName(ByVal path As String) As String

    Dim fso As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    GetFileName = fso.GetFileName(path)
End Function

' �t�H���_�쐬
Public Sub Mkdir(ByVal path As String)

    Dim rc As Variant
    
    With CreateObject("Scripting.FileSystemObject")
    
        If Not (.FolderExists(path)) Then
        
            rc = SHCreateDirectoryEx(0&, path, 0&)
        
        End If
        
    End With

End Sub

' �t�@�C���I��
Public Function ShowFileOpenDialog() As String

    ShowFileOpenDialog = Application.GetOpenFilename("Microsoft Excel�u�b�N, *.xlsx;*xls")
    
End Function

' �w�肳�ꂽ�u�b�N�Ɏw�肳�ꂽ�V�[�g�����݂��邩�𔻒�
Public Function ExistsReadWs(ByVal wb As Workbook, ByVal readSheet As String) As Boolean

    ExistsReadWs = True
    
    ' �w�肳�ꂽ�V�[�g�����݂��邩�𔻒�
    Dim ws As Worksheet
    
    For Each ws In wb.Worksheets
    
        If (ws.Name = readSheet) Then Exit Function
    
    Next ws
    
    ExistsReadWs = False

End Function

' �c�[���̂���t�H���_�ֈړ�
Public Sub ChangeDir()

    ChDrive ThisWorkbook.path
    ChDir ThisWorkbook.path
End Sub

' �t�H���_�̕�����𔲂��o��
Public Function GetFolderPath(ByVal fullPath As String)

    Dim pos As Long

    pos = InStrRev(fullPath, "\")
    
    GetFolderPath = Left(fullPath, pos)
    
End Function


' �����񑀍�

' C����̃R�����g���ɂ���
Public Function ConvCLangComment(ByVal str As String) As String

    ConvCLangComment = "/* " & str & " */"

End Function

' �V���O���N�H�e�[�V�����ň͂�
Public Function EnclosedInSQs(ByVal str As String) As String

    EnclosedInSQs = "`" & str & "`"

End Function

' Null��������
Public Function IsNullStr(ByVal str As String) As Boolean

    IsNullStr = False
    
    If (str = "NULL") Or (str = "Null") Or (str = "null") Then IsNullStr = True
    
End Function

' ���p��������Ԃ�
Public Function LenSByteChars(ByVal str As String) As Long

    LenSByteChars = LenB(StrConv(str, vbFromUnicode))

End Function

' �n�b�V���֐�
Public Function ToHash(Password As String) As String
    
    Dim objSHA256 As Variant
    Dim objUTF8   As Variant

    Dim bytes() As Byte
    Dim hash()  As Byte

    Dim i  As Long
    Dim wk As String

    Set objSHA256 = CreateObject("System.Security.Cryptography.SHA256Managed")
    Set objUTF8 = CreateObject("System.Text.UTF8Encoding")

    ' ������� UTF8 �ɃG���R�[�h���A�o�C�g�z��ɕϊ�
    bytes = objUTF8.GetBytes_4(Password)

    ' �n�b�V���l���v�Z�i�o�C�i���j
    hash = objSHA256.ComputeHash_2((bytes))

    ' �o�C�i����16�i��������ɕϊ�
    For i = 1 To UBound(hash) + 1
        wk = wk & Right("0" & Hex(AscB(MidB(hash, i, 1))), 2)
    Next i

    ' ���ʂ�Ԃ�
    ToHash = LCase(wk)

End Function

' .NET��String.Format�֐�����
Public Function StringFormat(ByVal msg As String, ByVal arg1 As String) As String

    StringFormat = Replace(msg, "{0}", arg1)

End Function

' .NET��String.Format�֐������i����2�j
Public Function StringFormat2(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String) As String

    msg = Replace(msg, "{1}", arg2)
    
    StringFormat2 = StringFormat(msg, arg1)

End Function

' .NET��String.Format�֐������i����3�j
Public Function StringFormat3(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String) As String

    msg = Replace(msg, "{2}", arg3)
    
    StringFormat3 = StringFormat2(msg, arg1, arg2)

End Function

' .NET��String.Format�֐������i����4�j
Public Function StringFormat4(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String) As String

    msg = Replace(msg, "{3}", arg4)
    
    StringFormat4 = StringFormat3(msg, arg1, arg2, arg3)

End Function

' .NET��String.Format�֐������i����5�j
Public Function StringFormat5(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String) As String

    msg = Replace(msg, "{4}", arg5)
    
    StringFormat5 = StringFormat4(msg, arg1, arg2, arg3, arg4)

End Function

' .NET��String.Format�֐������i����6�j
Public Function StringFormat6(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String) As String

    msg = Replace(msg, "{5}", arg6)
    
    StringFormat6 = StringFormat5(msg, arg1, arg2, arg3, arg4, arg5)

End Function

' .NET��String.Format�֐������i����7�j
Public Function StringFormat7(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String, ByVal arg7 As String) As String

    msg = Replace(msg, "{6}", arg7)
    
    StringFormat7 = StringFormat6(msg, arg1, arg2, arg3, arg4, arg5, arg6)

End Function

' .NET��String.Format�֐������i����8�j
Public Function StringFormat8(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String, ByVal arg7 As String, ByVal arg8 As String) As String

    msg = Replace(msg, "{7}", arg8)
    
    StringFormat8 = StringFormat7(msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7)

End Function

' .NET��String.Format�֐������i����9�j
Public Function StringFormat9(ByVal msg As String, ByVal arg1 As String, ByVal arg2 As String, ByVal arg3 As String, ByVal arg4 As String, ByVal arg5 As String, ByVal arg6 As String, ByVal arg7 As String, ByVal arg8 As String, ByVal arg9 As String) As String

    msg = Replace(msg, "{8}", arg9)
    
    StringFormat9 = StringFormat8(msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)

End Function

' NULL or Empty�`�F�b�N
Public Function IsNullOrEmpty(ByVal str As Variant) As Boolean

    IsNullOrEmpty = False

    If IsNull(str) Or IsEmpty(str) Then IsNullOrEmpty = True
    
End Function


' ���[�N�V�[�g����

' �w��V�[�g��A��̓��e���e�L�X�g�t�@�C���o�͂���
Public Sub WriteToTextFile(ByRef ws As Worksheet, ByVal fName As String)

    Dim fso As Object
    Dim ts As Object
    
    Dim strRec As String
    Dim lineCnt As Long
    Dim lineMax As Long
    
    Set fso = CreateFSO()
    
    ' �ŏI�s�̎擾
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


' ���̑�

' �R���N�V��������������
Public Function JoinCollection(ByVal c1 As Collection, ByVal c2 As Collection) As Collection

    Dim v As Variant
    
    For Each v In c2
    
        c1.Add (v)
        
    Next v
    
    Set JoinCollection = c1

End Function

' �����̃p�\�R���̃R���s���[�^����Ԃ�
Public Function GetMyComputerName() As String

  Dim strBuf As String * 21

  ' API�֐��ɂ���ăR���s���[�^�[�����擾
  GetComputerName strBuf, Len(strBuf)
    
  ' �㑱��Null����菜���ĕԂ�l��ݒ�
  GetMyComputerName = Left$(strBuf, InStr(strBuf, vbNullChar) - 1)

End Function

' Windows�̃��[�U����Ԃ�
Public Function GetWindowsUserName() As String

    Dim wsObj As Object
    Set wsObj = CreateObject("WScript.Network")

    GetWindowsUserName = wsObj.UserName
    
    Set wsObj = Nothing
    
End Function

' IP�A�h���X�擾�iWMI���g�p�j
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

' Guid�̐���
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

' HyperLink�N���b�N��
Private Sub Workbook_SheetBeforeRightClick(ByVal Sh As Object, ByVal Target As Range, Cancel As Boolean)

    If (Sh.Name <> wsList.Name) Then Exit Sub
    If (Target.Column <> 6) Then Exit Sub ' E��

    Cancel = True
    
    ' �N���b�N���ꂽ�Z��
    Dim r As Range: Set r = wsList.Range(Target.Address)
    
    Dim file As String: file = wsList.Range("A1").Offset(r.Row - 1).Value ' �t���p�X(A��)
    Dim step As Long: step = wsList.Range("B1").Offset(r.Row - 1).Value ' ��v�s(E��)
    
    If (file = "") Then Exit Sub
        
    ' �e�L�X�g�G�f�B�^�ŊJ��
    Call OpenInSakura(wsConfig.Range("B1").Value & "\" & file, step)

End Sub

' �e�L�X�g�G�f�B�^�Ŏw��t�@�C�����J��
Private Sub OpenInSakura(ByVal file As String, ByVal step As Long)

    Call Execute("""" & wsConfig.Range("B2").Value & """", """" & file & """", "-Y=" & CStr(step))

End Sub

' EXE�t�@�C���̎��s
Private Sub Execute(ByVal exe As String, ByVal arg1 As String, ByVal arg2 As String)

    Shell exe & " " & arg1 & " " & arg2, vbNormalFocus

End Sub

