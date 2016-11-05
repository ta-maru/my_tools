# encoding: utf-8

# 事前に抜き出したSQLファイルに対し、
# どのテーブル（またはビュー）を参照しているかの関連図を作成するための元ネタを抽出するためのスクリプト

# 使用方法：ruby analysis_A.rb {SQLファイルのあるフォルダ}


require 'kconv'
require 'csv'

$tableViews = [

  "tableA",
  "tableB",
  "tableC",
  "ViewA"
]


#
#=== メイン関数
#
def main

  Dir::entries(ARGV[0]).each do |file|

    next if ((file == ".") or (file == ".."))

    text = open(ARGV[0] + "\\" + file).read.toutf8.upcase # クエリを読み込む

    list = $tableViews.select { |x| text.include?(x.upcase) } # クエリが参照しているテーブル・ビューを抽出する

    list.each { |x| print (file.toutf8 + "\t" + x + "\n") } # 関連図作成用のための情報を出力する
  end
end

main
