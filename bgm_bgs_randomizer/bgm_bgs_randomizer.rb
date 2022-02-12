# BGM/BGS ランダマイザー ＋ ピッチランダマイザー
require "json"

# ファイル入力
puts "デコードしたjsonファイルが格納されているディレクトリパスを入力してください"
directory = gets.chomp
# puts directory

# Map***.jsonの形式を対象にする
json_path = directory + "/Map[0-9][0-9][0-9].json"
# puts "置換前の値"
# puts json_path

json_path_replace = json_path.gsub(/\\/){'/'}
# puts "置換後の値"
# puts json_path_replace

filename = Dir.glob(json_path_replace)
# puts filename

# ----------------------------------------------------------------------------------

# BGM数
bgm_total = 0
# BGS数
bgs_total = 0

# BGM/BGS数取得
filename.each { |i|
  File.open(i, "r") do |file|
    hash = JSON.load(file)

    # BGM
    if hash["@bgm"]["@name"].empty?
    else
      p hash["@bgm"]["@name"]
      bgm_total += 1
    end

    # BGS
    if hash["@bgs"]["@name"].empty?
    else
      p hash["@bgs"]["@name"]
      bgs_total += 1
    end
  end
}

puts "BGM総数"
puts bgm_total
puts "BGS総数"
puts bgs_total

# BGM/BGS一覧
# BGM数ぶん二次元配列を作成
bgms = Array.new(bgm_total) { Array.new(2,0) }
# p bgms
bgms_num = 0
# BGS数ぶん二次元配列を作成
bgss = Array.new(bgs_total) { Array.new(2,0) }
# p bgss
bgss_num = 0

# BGM/BGS一覧読み込み
filename.each { |i|
  File.open(i, "r") do |file|
    hash = JSON.load(file)

    puts("File:#{i}")

    # BGM
    if hash["@bgm"]["@name"].empty?
    else
      bgms[bgms_num] = hash["@bgm"]
      bgms_num += 1
    end

    # BGS
    if hash["@bgs"]["@name"].empty?
    else
      bgss[bgss_num] = hash["@bgs"]
      bgss_num += 1
    end
  end
}

puts "シャッフル前"
print bgms
print bgss
puts

# BGM一覧シャッフル
shuffle_bgms = bgms.shuffle
# BGS一覧シャッフル
shuffle_bgss = bgss.shuffle

puts "シャッフル後"
print shuffle_bgms
print shuffle_bgss
puts

# シャッフルBGM一覧
shuffle_bgms_num = 0
# シャッフルBGS一覧
shuffle_bgss_num = 0

# BGM/BGS一覧書き出し
filename.each { |i|
  # 何故かr+で実施したら末尾に追記の挙動になった
  # そのため別途wで書き込む形にしている
  File.open(i, "r") do |file2|
    hash2 = JSON.load(file2)

    puts("File:#{i}")

    # BGM
    if hash2["@bgm"]["@name"].empty?
    else
      hash2["@bgm"] = shuffle_bgms[shuffle_bgms_num]

      # ピッチランダマイザー
      hash2["@bgm"]["@pitch"] = rand(50..150)

      shuffle_bgms_num += 1
    end

    # BGS
    if hash2["@bgs"]["@name"].empty?
    else
      hash2["@bgs"] = shuffle_bgss[shuffle_bgss_num]

      # ピッチランダマイザー
      hash2["@bgs"]["@pitch"] = rand(50..150)

      shuffle_bgss_num += 1
    end

    # ファイル出力
    File.open(i, "w") do |file3|

      hash2_format = JSON.pretty_generate(hash2)
      # puts hash2_format

      file3.write(hash2_format)

    end

  end
}

puts "処理を終了します"
sleep 3

