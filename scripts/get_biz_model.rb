#encoding: utf-8

require 'kconv'
require 'find'

#
#=== �N���X���A���\�b�h���ASummary�^�O�R�����g���̔����o��
#
def main

  files = GetFiles(ARGV[0])

  files.each do |f|

    txt = open(f, "r").read.toutf8

    ary = parse(txt)

    f = f.gsub(ARGV[0] + "/", "")

    ary.each do |a|

      begin
        a.unshift(f)

        a.each_with_index do |aa, idx|

          print aa
          (idx != ((a.size) -1)) ? (print "\t") : (print "\n")
        end
      rescue => e
        STDERR.puts("Error!" + "\n")
        STDERR.puts(e.message + "\n")
        STDERR.puts(f + "\n")
        STDERR.puts(a.join(",") + "\n")
        exit
      end
    end
  end
end

#
#=== �\�[�X�̑���
#
def parse(txt)
  ary = []

  summaryTag1 = ""
  summaryTag2 = ""
  className = ""
  methodAccLv = ""
  methodName = ""
  methodIF = ""
  sqlId = ""

  until txt.empty? do
    case txt

      when (/\A\s*<summary>(.*?)<\/summary>/m)
        temp = deleteUnnecessaryStr($1) # �����Ő��K�\���͎g�p���Ȃ��B�g���ƌ㑱�́u$`�v���Ӑ}���Ȃ����̂ƂȂ�
        (summaryTag1 == "") ? (summaryTag1 = temp) : (summaryTag2 = temp)

      when (/\A\s+class\s+(\w+)/m)
        className = $1

      when (/\A(public|private)\s+\w+\s*<[\w\s,]+?>\s+(\w+)\s*\(.*?\)/m)
        methodLv = $1
        methodName = $2
        methodIF = deleteUnnecessaryStr($&)
        ary.push( [summaryTag1, className, summaryTag2, methodName, methodLv, methodIF, "-"] )

      when (/\A(public|private)\s+\S+\s+(\w+)\s*\(.*?\)/m)
        methodLv = $1
        methodName = $2
        methodIF = deleteUnnecessaryStr($&)
        ary.push( [summaryTag1, className, summaryTag2, methodName, methodLv, methodIF, "-"] )

      when (/\A\S*�u([\w_]+\-[SIUD]\d\d�v/u)
        sqlid = $1
        ary.push( [summaryTag1, className, summaryTag2, methodName, methodLv, "-", sqlId] )

      when (/\A\s+/m)
        ; # Skip

      when (/\A\S+/m)
        ; # Skip
    end
    txt = $`
  end
  ary
end

#
#=== �s�v�ȕ�����̍폜
#
def deleteUnnecessaryStr(str)
  str = str.gsub(/\/\/\//, "".gsub(/^\s*/, "").gsub(/\s*$/, "").gsub(/\n/, "")
  str = str.gsub(\s\s/, " ").gsub(/private\s+/, "").sub(/public\s+/, "")
end

#
#=== �t�@�C���ꗗ�擾
#
def GetFiles(path)
  list = []

  Find.find(path) do |f|
    if (File.ftype(f) == "file")
      list.push(f) if (/.*\.cs$/ =~ f)
    end
  end

  list
end
