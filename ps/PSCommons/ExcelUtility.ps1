<#
    Select-SQL�̌��ʂ��w��V�[�g�ɏo�͂���
#>
function Output-QueryTable($workbook, $sheetName, $rangeAddress, $conStr, $qtSQL)
{
    $workSheets = $workBook.WorkSheets
    $workSheet = $workSheets.Item($sheetName)

    $qt = $workSheet.QueryTables

    $qt2 = $qt.Add($conStr, $workSheet.Range($rangeAddress), $null)

    $qt2.CommandText          = $qtSQL    # SQL���̐ݒ�
    $qt2.Name                 = $qtName   # �N�G���e�[�u���̖��O�ݒ�
    $qt2.FieldNames           = $true     # �t�B�[���h�����܂�
    $qt2.RowNumbers           = $false    # �s�ԍ����܂�
    $qt2.FillAdjacentFormulas = $false    # �f�[�^�̗אڂ����ɐ������R�s�[����
    $qt2.PreserveFormatting   = $true     # �Z��������ێ�����
    $qt2.RefreshOnFileOpen    = $false    # �t�@�C�����J�����Ƀf�[�^���X�V����
    $qt2.BackgroundQuery      = $true     # �o�b�N�O���E���h�ōX�V����
    $qt2.RefreshStyle         = 0         # �ύX���ꂽ���R�[�h�̃f�[�^�X�V���̏����i0: xlOverwriteCells�A1: xlInsertDeleteCells�A2: xlInsertEntireRows�j
    $qt2.SavePassword         = $false    # �p�X���[�h��ۑ�����
    $qt2.SaveData             = $true     # �ۑ��O�Ƀ��[�N�V�[�g����O���f�[�^���폜����
    $qt2.AdjustColumnWidth    = $false    # ��̕��𒲐�����
    $qt2.RefreshPeriod        = 0         # ����I�ɍX�V����
    $qt2.PreserveColumnInfo   = $true     # ��̕��בւ�/�t�B���^/���C�A�E�g��ێ�����

    # SQL����Excel�ɓǍ�
    [void]$qt2.Refresh($false)
    [void]$qt2.Delete()

    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($qt2)
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($qt)
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($workSheet)
}

<#
    COM�I�u�W�F�N�g�̉��
#>
Function Release-ComObject
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
