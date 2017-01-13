$ErrorActionPreference = "Stop" # ��O�������ɒ�~����

try
{
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Configuration")
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Security")
    [void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    # ���ʏ����̃��[�h
    $rootDir = Resolve-Path((Split-Path $MyInvocation.MyCommand.Path -parent) + "\..\")
    . (Join-Path $rootDir "PSCommons\ExcelUtility.ps1")
    . (Join-Path $rootDir "PSCommons\Misc.ps1")

    $configName = "XXX.exe.config"
    $dllName    = "XXX.dll"

    $curDir = [System.AppDomain]::CurrentDomain.BaseDirectory
    $configPath = Join-Path $curDir $configName
    $dllPath    = Join-Path $curDir $dllName

    if (($input.GetType() -eq [array]) -and ($input.Count > 0))
    {
        # �p�C�v���C�������擾
        $arg1 = $input[0]
        $arg2 = $input[1]
        $arg3 = $input[2]
    }
    else
    {
        $curDir = "C:\temp\XXX\Debug\"
        Set-Location $curDir

        $configPath = Join-Path $curDir $configName
        $dllPath    = Join-Path $curDir $dllName
        
        $tradeBook = $null
    }

    [System.AppDomain]::CurrentDomain.SetData("APP_CONFIG_FILE", $configPath)

    Add-Type -AssemblyName System.Configuration
    Add-Type -Path $dllPath
    [void][System.Reflection.Assembly]::LoadFrom($dllPath)

    if ($null -eq $tradeBook)
    {
        $tradeBook = New-Object XXXNS.XXXCLS
    }
    
    # ���[�t�@�C���p�X
    $pathToDefinedReport = Split-Path $MyInvocation.MyCommand.Path -parent
    $xlFilePath = Join-Path $pathToDefinedReport "XYZ.xlsm"
    
    # Excel����
    $excel = New-Object -COM Excel.Application
    $excel.DisplayAlerts = $false
    
    # ���[���J��
    $workbooks = $excel.Workbooks
    $workbook = $workbooks.Open($xlFilePath, 0, $true, [System.Reflection.Missing]::Value, "XXXX")
    
    # ���[�\��
    $excel.Visible = $true
}
catch [Exception]
{
    $errmsg = "Exception Message: `n" + $Error[0].Exception.Message + "`n`n" + "ScriptStackTrace: `n" + $Error[0].ScriptStackTrace

    [System.Windows.Forms.MessageBox]::Show($errmsg, "��O�iPowerShell�j")
    throw $Error[0]
}
finally
{
    # COM�I�u�W�F�N�g���
    Release-ComObject $workbook, $workbooks, $excel
}
