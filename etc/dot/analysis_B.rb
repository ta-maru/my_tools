# encoding: utf-8

# INTO(create, insert), UPDATE, FROM(delete) のあとに続くテーブルを抽出する
#

# 使用方法：ruby analysis_A.rb {SQLファイルのあるフォルダ}


require 'kconv'
require 'csv'


#
#=== メイン関数
#
def main

  Dir::entries(ARGV[0]).each do |file|

    next if ((file == ".") or (file == ".."))

    text = open(ARGV[0] + "\\" + file).read.toutf8.upcase # クエリを読み込む

    table = nil

    # INTO, UPDATE, FROMのあとに続くテーブルを抽出
    if (text =~ /\s+INTO\s+(\S+)\s+/mi)
      table = $1

    elsif (text =~ /\s+UPDATE\s+(\S+)\s+/mi)
      table = $1

    elsif (text =~ /\s+FROM\s+(\S+)\s+/mi)
      table = $1

    end

    print (file.toutf8 + "\t" + table + "\n") if (table != nil)
  end
end

main
