<#
   COMに関する関数群
#>

# 備忘
# Excel 2003とそれ以降のバージョンが共存している環境での実行は注意
# Excel 2003でそれ以降のバージョンのファイルを処理する場合があり、その場合落ちる(互換パックを入れることにより改善)

# TODO：グローバル変数的なものを使用しなくてもよいならそちらの方がよいだろう
$script:g_Excel
$script:g_Workbooks
$script:g_Workbook
$script:g_Worksheets
$script:g_Worksheet
$script:g_QueryTables
$script:g_QueryTable

# TODO：関数名、要見直し

# COMオブジェクト使用の準備
Function SetupComObject
{
    Param($xlFile, $sheet, $outputAddress, $connectionString, $commandText, $qtName)

    SetupExcelComObject -xlFile $xlFile

    SetupWorksheetAndQueryTable  -sheetName $sheet -connectionString $connectionString -outputAddress $outputAddress -qtCmdTxt $commandText -qtName $qtName
}

# Excel COMオブジェクトの準備
Function SetupExcelComObject
{
    Param($xlFile)

    SetupExcel

    OpenWorkbook -xlFileName $xlFile
}

# WorksheetとQueryTableの準備
Function SetupWorksheetAndQueryTable
{
    Param($sheetName, $outputAddress, $connectionString, $qtCmdTxt, $qtName, $fieldNames)

    ActivateWorksheet -sheetName $sheetName

    SetupQueryTable -connectionString $connectionString -outputAddress $outputAddress -qtCmdTxt $qtCmdTxt -qtName $qtName -fieldNames $fieldNames
}

# COMオブジェクトの解放
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

# 以降の関数は本スクリプト内でのみ使用（TODO：他に良い方法あれば後で考える）

# Excel COMオブジェクトの準備
Function SetupExcel
{
    # Excel生成
    $script:g_Excel = New-Object -COM Excel.Application
    $script:g_Excel.DisplayAlerts = $false

    $script:g_Workbooks = $script:g_Excel.Workbooks
}

# 指定のファイルを開く
Function OpenWorkbook
{
    Param($xlFileName)

    $script:g_Workbook = $script:g_Workbooks.Open($xlFileName)
}

# 指定のシートを活性化
Function ActivateWorksheet
{
    Param($sheetName)

    $script:g_Worksheets  = $script:g_Workbook.WorkSheets

    $script:g_Worksheet   = $script:g_Worksheets.Item($sheetName)

    $script:g_QueryTables = $script:g_worksheet.QueryTables
}

# クエリテーブルの準備
Function SetupQueryTable
{
    Param($connectionString, $outputAddress, $qtCmdTxt, $qtName, $fieldNames=$false)

    $script:g_QueryTable = $script:g_QueryTables.Add($connectionString, $script:g_WorkSheet.Range($outputAddress), $null)

    $script:g_QueryTable.CommandText          = $qtCmdTxt   # SQL文の設定
    $script:g_QueryTable.Name                 = $qtName     # クエリテーブルの名前設定
    $script:g_QueryTable.FieldNames           = $fieldNames # フィールド名を含む
    $script:g_QueryTable.RowNumbers           = $false      # 行番号を含む
    $script:g_QueryTable.FillAdjacentFormulas = $true       # データの隣接する列に数式をコピーする
    $script:g_QueryTable.PreserveFormatting   = $true       # セル書式を保持する
    $script:g_QueryTable.RefreshOnFileOpen    = $false      # ファイルを開く時にデータを更新する
    $script:g_QueryTable.BackgroundQuery      = $true       # バックグラウンドで更新する
    $script:g_QueryTable.RefreshStyle         = 0           # 変更されたレコード(行)のデータ更新時の処理
    $script:g_QueryTable.SavePassword         = $false      # パスワードを保存する
    $script:g_QueryTable.SaveData             = $true       # 保存前にワークシートから外部データを削除する
    $script:g_QueryTable.AdjustColumnWidth    = $false      # 列の幅を調整する
    $script:g_QueryTable.RefreshPeriod        = 0           # 定期的に更新する
    $script:g_QueryTable.PreserveColumnInfo   = $true       # 列の並べ替え/フィルタ/レイアウトを保持する
}

# Excelクエリテーブル・データ読込の実行
Function QueryTableRefresh
{
    [void]$script:g_QueryTable.Refresh($false)
}

# Excelクエリテーブル・データ読込の実行（実行後クエリテーブルを削除する）
Function QueryTableRefreshAndDelete
{
    [void]$script:g_QueryTable.Refresh($false)
    [void]$script:g_QueryTable.Delete()
}

# Excelマクロの実行
Function RunMacro
{
    Param($macro)

   [void]$script:g_Excel.Run($macro)
}

# Excelマクロの実行
Function RunMacro2
{
    Param($macro, $arg1, $arg2)

   [void]$script:g_Excel.Run($macro, $arg1, $arg2)
}

# Excelを表示する
Function ShowExcel
{
    $script:g_Excel.Visible = $true
}

# TODO：もう少しうまく共通化する

# Excelファイルを保存する（Excel 97-2003 ブック形式）
Function SaveExcel
{
    Param($fileName)

#    $script:g_Workbook.SaveAs($fileName, -4143) あとで正式に直す
    $script:g_Workbook.SaveAs($fileName, 52)
}

# Excelファイルを保存する（Excel マクロ有効ブック）
Function SaveExcelMacro
{
    Param($fileName)

    $script:g_Workbook.SaveAs($fileName, 52)
}

# COMオブジェクトの解放
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
