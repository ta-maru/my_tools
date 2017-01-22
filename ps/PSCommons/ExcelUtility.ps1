<#
    Select-SQLの結果を指定シートに出力する
#>
function Output-QueryTable($workbook, $sheetName, $rangeAddress, $conStr, $qtSQL)
{
    $workSheets = $workBook.WorkSheets
    $workSheet = $workSheets.Item($sheetName)

    $qt = $workSheet.QueryTables

    $qt2 = $qt.Add($conStr, $workSheet.Range($rangeAddress), $null)

    $qt2.CommandText          = $qtSQL    # SQL文の設定
    $qt2.Name                 = $qtName   # クエリテーブルの名前設定
    $qt2.FieldNames           = $true     # フィールド名を含む
    $qt2.RowNumbers           = $false    # 行番号を含む
    $qt2.FillAdjacentFormulas = $false    # データの隣接する列に数式をコピーする
    $qt2.PreserveFormatting   = $true     # セル書式を保持する
    $qt2.RefreshOnFileOpen    = $false    # ファイルを開く時にデータを更新する
    $qt2.BackgroundQuery      = $true     # バックグラウンドで更新する
    $qt2.RefreshStyle         = 0         # 変更されたレコードのデータ更新時の処理（0: xlOverwriteCells、1: xlInsertDeleteCells、2: xlInsertEntireRows）
    $qt2.SavePassword         = $false    # パスワードを保存する
    $qt2.SaveData             = $true     # 保存前にワークシートから外部データを削除する
    $qt2.AdjustColumnWidth    = $false    # 列の幅を調整する
    $qt2.RefreshPeriod        = 0         # 定期的に更新する
    $qt2.PreserveColumnInfo   = $true     # 列の並べ替え/フィルタ/レイアウトを保持する

    # SQL結果Excelに読込
    [void]$qt2.Refresh($false)
    [void]$qt2.Delete()

    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($qt2)
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($qt)
    [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($workSheet)
}

<#
    COMオブジェクトの解放
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
