<#
   ���ʂŎg�p����G���Ȋ֐��Q
#>

# TODO�F��剻���Ă����ꍇ�A����������

# Type�̔z��̎擾
Function GetTypeArray
{
    Param($items)

    $list = New-Object 'System.Collections.Generic.List[System.Type]'

    foreach($r in $items)
    {
        $list.Add($r.GetType())
    }

    return $list.ToArray()
}

# IEnumerable�^��List<object>�^�ɕϊ�
Function IEnumToList
{
    Param($ienum);


    $list = New-Object 'System.Collections.Generic.List[object]'
    
    foreach($r in $ienum)
    {
        $list.Add($r)
    }

    return $list
}

# �_�C�A���O�\��
Function ShowMsg
{
    Param($message, $title)

    [System.Windows.Forms.MessageBox]::Show($message, $title)
}
