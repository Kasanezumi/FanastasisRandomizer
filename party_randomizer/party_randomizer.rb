# 解放される仲間をランダム化
require "json"

# ファイル入力
puts "デコードしたjsonファイルが格納されているディレクトリパスを入力してください"
directory = gets.chomp
# puts directory

# ----------------------------------------------------------------------------------

# パーティの解放フラグ
party_flag = [647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,662,663]

# パーティの解放フラグの場所
party_location = [["Map587.json",'hash2["@events"]["14"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map244.json",'hash2["@events"]["52"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map261.json",'hash2["@events"]["3"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map357.json",'hash2["@events"]["1"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map591.json",'hash2["@events"]["1"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map531.json",'hash2["@events"]["1"]["@pages"][0]["@list"][16]["@parameters"]'],
                  ["Map283.json",'hash2["@events"]["2"]["@pages"][0]["@list"][13]["@parameters"]'],
                  ["Map408.json",'hash2["@events"]["5"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map519.json",'hash2["@events"]["5"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map101.json",'hash2["@events"]["120"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map089.json",'hash2["@events"]["38"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map128.json",'hash2["@events"]["42"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map761.json",'hash2["@events"]["2"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map394.json",'hash2["@events"]["9"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map427.json",'hash2["@events"]["3"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map116.json",'hash2["@events"]["5"]["@pages"][0]["@list"][7]["@parameters"]'],
                  ["Map540.json",'hash2["@events"]["64"]["@pages"][0]["@list"][7]["@parameters"]']
]

p party_flag
p party_location

puts "シャッフル前"
print party_flag
puts

# パーティ解放フラグシャッフル
shuffle_party_flag = party_flag.shuffle

puts "シャッフル後"
print shuffle_party_flag
puts

# パーティ解放フラグカウンタ
shuffle_party_num = 0

# アイテム一覧書き出し
party_location.each { |i|
  # 何故かr+で実施したら末尾に追記の挙動になった
  # そのため別途wで書き込む形にしている
  # puts "File:#{directory}\\#{i[0]}"
  filepath = "#{directory}\\#{i[0]}"
  puts filepath
  File.open(filepath, "r") do |file2|
    hash2 = JSON.load(file2)

    puts "変更前"
    puts eval("#{i[1]}")

    # 変更後の@parametersの値を設定する
    puts "変更値"
    puts "[#{shuffle_party_flag[shuffle_party_num]},#{shuffle_party_flag[shuffle_party_num]},0]"

    # evalは文字列を変数に変える
    eval("#{i[1]} = [#{shuffle_party_flag[shuffle_party_num]},#{shuffle_party_flag[shuffle_party_num]},0]")

    puts "変更後"
    puts eval("#{i[1]}")
    puts

    shuffle_party_num += 1

    # ファイル出力
    File.open(filepath, "w") do |file3|

      hash2_format = JSON.pretty_generate(hash2)
      # puts hash2_format

      file3.write(hash2_format)

    end

  end
}

puts "処理を終了します"
sleep 3
