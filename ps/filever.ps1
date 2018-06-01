# 指定フォルダ配下のファイルの情報を表示

$list = Get-ChildItem $args[0]

foreach ($r in $list)
{
    if ($r.PSIsContainer) { continue }

    $o1 = $r.FullName
    $o2 = $r.LastWriteTime.ToString("yyyy/MM/dd HH:mm:ss")
    $o3 = $r.Length
    $o4 = $r.VersionInfo.FileVersion

    Write-Host "$o1`t$o2`t$o3`t$o4`r"
}
