Attribute VB_Name = "Misc"
Option Explicit

Declare Function SHCreateDirectoryEx Lib "shell32" Alias _
                                         "SHCreateDirectoryExA" (ByVal hwnd As Long, ByVal pszPath As String, ByVal psa As Long) As Long

' �t�@�C������

' File System Object�̐���
Public Function CreateFSO() As Object

    Set CreateFSO = CreateObject("Scripting.FileSystemObject")

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
