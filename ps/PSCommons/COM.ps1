<#
   COM�Ɋւ���֐��Q
#>

# ���Y
# Excel 2003�Ƃ���ȍ~�̃o�[�W�������������Ă�����ł̎��s�͒���
# Excel 2003�ł���ȍ~�̃o�[�W�����̃t�@�C������������ꍇ������A���̏ꍇ������(�݊��p�b�N�����邱�Ƃɂ����P)

# TODO�F�O���[�o���ϐ��I�Ȃ��̂��g�p���Ȃ��Ă��悢�Ȃ炻����̕����悢���낤
$script:g_Excel
$script:g_Workbooks
$script:g_Workbook
$script:g_Worksheets
$script:g_Worksheet
$script:g_QueryTables
$script:g_QueryTable

# TODO�F�֐����A�v������

# COM�I�u�W�F�N�g�g�p�̏���
Function SetupComObject
{
    Param($xlFile, $sheet, $outputAddress, $connectionString, $commandText, $qtName)

    SetupExcelComObject -xlFile $xlFile

    SetupWorksheetAndQueryTable  -sheetName $sheet -connectionString $connectionString -outputAddress $outputAddress -qtCmdTxt $commandText -qtName $qtName
}

# Excel COM�I�u�W�F�N�g�̏���
Function SetupExcelComObject
{
    Param($xlFile)

    SetupExcel

    OpenWorkbook -xlFileName $xlFile
}

# Worksheet��QueryTable�̏���
Function SetupWorksheetAndQueryTable
{
    Param($sheetName, $outputAddress, $connectionString, $qtCmdTxt, $qtName, $fieldNames)

    ActivateWorksheet -sheetName $sheetName

    SetupQueryTable -connectionString $connectionString -outputAddress $outputAddress -qtCmdTxt $qtCmdTxt -qtName $qtName -fieldNames $fieldNames
}

# COM�I�u�W�F�N�g�̉��
Function ReleaseComObject
{
    Param($excelQuit)
    ReleaseComObjectCore -comObjects ($script:g_QueryTable, $script:g_QueryTables, $script:g_Worksheet, $script:g_Worksheets, $script:g_Workbook)
    
    if ($script:g_Excel -ne $null)
    {
        if ($excelQuit)
        {
            $script:g_Excel.quit()
        }
    }
    ReleaseComObjectCore -comObjects ( $script:g_Workbooks, $script:g_Excel )
}

# �ȍ~�̊֐��͖{�X�N���v�g���ł̂ݎg�p�iTODO�F���ɗǂ����@����Ό�ōl����j

# Excel COM�I�u�W�F�N�g�̏���
Function SetupExcel
{
    # Excel����
    $script:g_Excel = New-Object -COM Excel.Application
    $script:g_Excel.DisplayAlerts = $false

    $script:g_Workbooks = $script:g_Excel.Workbooks
}

# �w��̃t�@�C�����J��
Function OpenWorkbook
{
    Param($xlFileName)

    $script:g_Workbook = $script:g_Workbooks.Open($xlFileName)
}

# �w��̃V�[�g��������
Function ActivateWorksheet
{
    Param($sheetName)

    $script:g_Worksheets  = $script:g_Workbook.WorkSheets

    $script:g_Worksheet   = $script:g_Worksheets.Item($sheetName)

    $script:g_QueryTables = $script:g_worksheet.QueryTables
}

# �N�G���e�[�u���̏���
Function SetupQueryTable
{
    Param($connectionString, $outputAddress, $qtCmdTxt, $qtName, $fieldNames=$false)

    $script:g_QueryTable = $script:g_QueryTables.Add($connectionString, $script:g_WorkSheet.Range($outputAddress), $null)

    $script:g_QueryTable.CommandText          = $qtCmdTxt   # SQL���̐ݒ�
    $script:g_QueryTable.Name                 = $qtName     # �N�G���e�[�u���̖��O�ݒ�
    $script:g_QueryTable.FieldNames           = $fieldNames # �t�B�[���h�����܂�
    $script:g_QueryTable.RowNumbers           = $false      # �s�ԍ����܂�
    $script:g_QueryTable.FillAdjacentFormulas = $true       # �f�[�^�̗אڂ����ɐ������R�s�[����
    $script:g_QueryTable.PreserveFormatting   = $true       # �Z��������ێ�����
    $script:g_QueryTable.RefreshOnFileOpen    = $false      # �t�@�C�����J�����Ƀf�[�^���X�V����
    $script:g_QueryTable.BackgroundQuery      = $true       # �o�b�N�O���E���h�ōX�V����
    $script:g_QueryTable.RefreshStyle         = 0           # �ύX���ꂽ���R�[�h(�s)�̃f�[�^�X�V���̏���
    $script:g_QueryTable.SavePassword         = $false      # �p�X���[�h��ۑ�����
    $script:g_QueryTable.SaveData             = $true       # �ۑ��O�Ƀ��[�N�V�[�g����O���f�[�^���폜����
    $script:g_QueryTable.AdjustColumnWidth    = $false      # ��̕��𒲐�����
    $script:g_QueryTable.RefreshPeriod        = 0           # ����I�ɍX�V����
    $script:g_QueryTable.PreserveColumnInfo   = $true       # ��̕��בւ�/�t�B���^/���C�A�E�g��ێ�����
}

# Excel�N�G���e�[�u���E�f�[�^�Ǎ��̎��s
Function QueryTableRefresh
{
    [void]$script:g_QueryTable.Refresh($false)
}

# Excel�N�G���e�[�u���E�f�[�^�Ǎ��̎��s�i���s��N�G���e�[�u�����폜����j
Function QueryTableRefreshAndDelete
{
    [void]$script:g_QueryTable.Refresh($false)
    [void]$script:g_QueryTable.Delete()
}

# Excel�}�N���̎��s
Function RunMacro
{
    Param($macro)

   [void]$script:g_Excel.Run($macro)
}

# Excel�}�N���̎��s
Function RunMacro2
{
    Param($macro, $arg1, $arg2)

   [void]$script:g_Excel.Run($macro, $arg1, $arg2)
}

# Excel��\������
Function ShowExcel
{
    $script:g_Excel.Visible = $true
}

# TODO�F�����������܂����ʉ�����

# Excel�t�@�C����ۑ�����iExcel 97-2003 �u�b�N�`���j
Function SaveExcel
{
    Param($fileName)

#    $script:g_Workbook.SaveAs($fileName, -4143) ���ƂŐ����ɒ���
    $script:g_Workbook.SaveAs($fileName, 52)
}

# Excel�t�@�C����ۑ�����iExcel �}�N���L���u�b�N�j
Function SaveExcelMacro
{
    Param($fileName)

    $script:g_Workbook.SaveAs($fileName, 52)
}

# COM�I�u�W�F�N�g�̉��
Function ReleaseComObjectCore
{
    Param($comObjects)

    foreach ($r in $comObjects)
    {
        if ($r -ne $null)
        {
            [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($r)
            $r = $null
        }
    }

    [System.GC]::Collect()
}
