#encoding: utf-8

require 'kconv'
require 'find'

#
#=== クラス名、メソッド名、Summaryタグコメント等の抜き出し
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
#=== ソースの走査
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
        temp = deleteUnnecessaryStr($1) # ここで正規表現は使用しない。使うと後続の「$`」が意図しないものとなる
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

      when (/\A\S*「([\w_]+\-[SIUD]\d\d」/u)
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
#=== 不要な文字列の削除
#
def deleteUnnecessaryStr(str)
  str = str.gsub(/\/\/\//, "".gsub(/^\s*/, "").gsub(/\s*$/, "").gsub(/\n/, "")
  str = str.gsub(\s\s/, " ").gsub(/private\s+/, "").sub(/public\s+/, "")
end

#
#=== ファイル一覧取得
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
