# 武器/防具/アイテムをごっちゃに混ぜた版
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

# アイテム数
item_total = 0

# アイテム数取得
filename.each { |i|
  File.open(i, "r") do |file|
    hash = JSON.load(file)
    hash["@events"].each_with_index { |file_events, j|
      file_events[1]["@pages"].each_with_index { |file_pages, k|
        file_events[1]["@pages"][k]["@list"].each_with_index{ |file_list, l|
          if ((file_events[1]["@pages"][k]["@list"][l]["@code"] == 126 \
          && (5..519) === file_events[1]["@pages"][k]["@list"][l]["@parameters"][0]) \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 127 \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 128) \
          && file_events[1]["@pages"][k]["@list"][l]["@parameters"][1] == 0
            item_total += 1
          end
        }
      }
    }
  end
}

puts "アイテム総数"
puts item_total

# アイテム一覧
# アイテム数ぶん二次元配列を作成
items = Array.new(item_total) { Array.new(2,0) }
# p items
items_num = 0

# アイテム一覧読み込み
filename.each { |i|
  File.open(i, "r") do |file|
    hash = JSON.load(file)

    puts("File:#{i}")

    hash["@events"].each_with_index { |file_events, j|
      # puts("loop_@events:#{j}")

      file_events[1]["@pages"].each_with_index { |file_pages, k|
        # puts("loop_@pages:#{k}")

        #puts file_events[1]["@pages"][k]

        # @pagesは配列のため数値指定
        file_events[1]["@pages"][k]["@list"].each_with_index{ |file_list, l|
          # puts("loop_list:#{l}")

          # @codeの126がアイテム入手イベントを指す
          # 同様に127は武器で128は防具
          # 2行目はカラムの2番目が0以外?だと減算になるため
          # 5..519はアイテムの中で貴重品でないもの
          if ((file_events[1]["@pages"][k]["@list"][l]["@code"] == 126 \
          && (5..519) === file_events[1]["@pages"][k]["@list"][l]["@parameters"][0]) \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 127 \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 128) \
          && file_events[1]["@pages"][k]["@list"][l]["@parameters"][1] == 0
            # puts file_events[1]["@pages"][k]["@list"][l]["@parameters"][0]
            # 0番目がアイテム名で1番目がアイテムタイプ
            items[items_num][0] = file_events[1]["@pages"][k]["@list"][l]["@parameters"][0]
            items[items_num][1] = file_events[1]["@pages"][k]["@list"][l]["@code"]
            items_num += 1
          end
        }

      }

    }

  end
}

puts "シャッフル前"
print items
puts

# アイテム一覧シャッフル
shuffle_items = items.shuffle

puts "シャッフル後"
print shuffle_items
puts

# シャッフルアイテム一覧
shuffle_items_num = 0

# アイテム一覧書き出し
filename.each { |i|
  # 何故かr+で実施したら末尾に追記の挙動になった
  # そのため別途wで書き込む形にしている
  File.open(i, "r") do |file2|
    hash2 = JSON.load(file2)

    puts("File:#{i}")

    hash2["@events"].each_with_index { |file_events, j|
      # puts("loop_@events:#{j}")

      hash2["@events"][file_events[0]]["@pages"].each_with_index { |file_pages, k|
        # puts("loop_@pages:#{k}")

        # @pagesは配列のため数値指定
        hash2["@events"][file_events[0]]["@pages"][k]["@list"].each_with_index{ |file_list, l|
          # puts("loop_list:#{l}")

          # @codeの126がアイテム入手イベントを指す
          if ((file_events[1]["@pages"][k]["@list"][l]["@code"] == 126 \
          && (5..519) === file_events[1]["@pages"][k]["@list"][l]["@parameters"][0]) \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 127 \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 128) \
          && file_events[1]["@pages"][k]["@list"][l]["@parameters"][1] == 0
            # puts "変更前"
            # puts hash["@events"][file_events[0]]["@pages"][k]["@list"][l]["@parameters"][0]
            # ランダム化したアイテムを設定
            # 0番目がアイテム名で1番目がアイテムタイプ
            hash2["@events"][file_events[0]]["@pages"][k]["@list"][l]["@parameters"][0] = shuffle_items[shuffle_items_num][0]
            hash2["@events"][file_events[0]]["@pages"][k]["@list"][l]["@code"] = shuffle_items[shuffle_items_num][1]
            # puts "変更後"
            # puts hash["@events"][file_events[0]]["@pages"][k]["@list"][l]["@parameters"][0]
            shuffle_items_num += 1
          end
        }

      }

    }

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
