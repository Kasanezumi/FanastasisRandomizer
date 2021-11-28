# 異種族のオーブまでのロジック有りアイテムランダマイザー
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
# リソース設定

# アイテムの配置場所（ロケーション）
items_placement_list = [ #マップファイル名、ロケーションパス、必要アイテム
  ["Map256.json",'hash["@events"]["16"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map256.json",'hash["@events"]["23"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map256.json",'hash["@events"]["24"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map662.json",'hash["@events"]["1"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map369.json",'hash["@events"]["24"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map369.json",'hash["@events"]["30"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map006.json",'hash["@events"]["7"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map006.json",'hash["@events"]["1"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map006.json",'hash["@events"]["2"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map006.json",'hash["@events"]["5"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map006.json",'hash["@events"]["6"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map499.json",'hash["@events"]["1"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map499.json",'hash["@events"]["2"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map370.json",'hash["@events"]["25"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map370.json",'hash["@events"]["32"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map004.json",'hash["@events"]["7"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map004.json",'hash["@events"]["1"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map004.json",'hash["@events"]["2"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map004.json",'hash["@events"]["5"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map037.json",'hash["@events"]["5"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map371.json",'hash["@events"]["26"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map371.json",'hash["@events"]["33"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map002.json",'hash["@events"]["1"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map002.json",'hash["@events"]["5"]["@pages"][0]["@list"][8]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map002.json",'hash["@events"]["7"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map002.json",'hash["@events"]["8"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map373.json",'hash["@events"]["6"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map375.json",'hash["@events"]["2"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map375.json",'hash["@events"]["4"]["@pages"][0]["@list"][0]' ,"Nothing"],
  ["Map530.json",'hash["@events"]["8"]["@pages"][0]["@list"][9]' ,"Nothing"],
  ["Map530.json",'hash["@events"]["2"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map255.json",'hash["@events"]["9"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map255.json",'hash["@events"]["12"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map255.json",'hash["@events"]["8"]["@pages"][0]["@list"][8] ',"Nothing"],
  ["Map255.json",'hash["@events"]["14"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map431.json",'hash["@events"]["12"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map431.json",'hash["@events"]["25"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map431.json",'hash["@events"]["63"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map036.json",'hash["@events"]["7"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map036.json",'hash["@events"]["2"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map036.json",'hash["@events"]["3"]["@pages"][0]["@list"][8]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map036.json",'hash["@events"]["1"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map036.json",'hash["@events"]["6"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map036.json",'hash["@events"]["8"]["@pages"][0]["@list"][0]' ,"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map036.json",'hash["@events"]["10"]["@pages"][0]["@list"][0]',"The_key_to_the_coastal_shrine_maiden"], # ☆海岸巫女の鍵
  ["Map257.json",'hash["@events"]["7"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map664.json",'hash["@events"]["1"]["@pages"][0]["@list"][8]' ,"Nothing"],
  ["Map258.json",'hash["@events"]["12"]["@pages"][0]["@list"][9]',"Nothing"],
  ["Map258.json",'hash["@events"]["21"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map258.json",'hash["@events"]["23"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map258.json",'hash["@events"]["24"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map258.json",'hash["@events"]["27"]["@pages"][0]["@list"][8]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map258.json",'hash["@events"]["28"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map258.json",'hash["@events"]["31"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map258.json",'hash["@events"]["33"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map258.json",'hash["@events"]["34"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map258.json",'hash["@events"]["37"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map258.json",'hash["@events"]["39"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map259.json",'hash["@events"]["11"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["13"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["14"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["18"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["19"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["20"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["21"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["22"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map259.json",'hash["@events"]["27"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map259.json",'hash["@events"]["28"]["@pages"][0]["@list"][8]',"Nothing"],
  ["Map259.json",'hash["@events"]["29"]["@pages"][0]["@list"][0]',"Nothing"],
  ["Map260.json",'hash["@events"]["17"]["@pages"][0]["@list"][8]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["18"]["@pages"][0]["@list"][8]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["19"]["@pages"][0]["@list"][8]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["31"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["33"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["34"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["35"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["36"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["37"]["@pages"][0]["@list"][8]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["23"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["38"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["39"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["40"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map260.json",'hash["@events"]["42"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["3"]["@pages"][0]["@list"][8]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["5"]["@pages"][0]["@list"][8]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["2"]["@pages"][0]["@list"][8]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["6"]["@pages"][0]["@list"][0]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["7"]["@pages"][0]["@list"][0]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["8"]["@pages"][0]["@list"][0]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["9"]["@pages"][0]["@list"][0]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map588.json",'hash["@events"]["10"]["@pages"][0]["@list"][0]',"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map589.json",'hash["@events"]["1"]["@pages"][0]["@list"][8]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map589.json",'hash["@events"]["3"]["@pages"][0]["@list"][0]' ,"Sunken_ship_key"], # ☆沈没船の鍵
  ["Map261.json",'hash["@events"]["4"]["@pages"][0]["@list"][0]' ,"Sunken_ship_key"] # ☆沈没船の鍵
]

# 必要アイテム
# ★異種族のオーブ
heterogeneous_orbs = {"rgss3_klass"=>"RPG::EventCommand", "@indent"=>0, "@code"=>126, "@parameters"=>[940, 0, 0, 1]}
# ☆海岸巫女の鍵
the_key_to_the_coastal_shrine_maiden = {"rgss3_klass"=>"RPG::EventCommand", "@indent"=>0, "@code"=>126, "@parameters"=>[881, 0, 0, 1]}
# ☆沈没船の鍵
sunken_ship_key = {"rgss3_klass"=>"RPG::EventCommand", "@indent"=>0, "@code"=>126, "@parameters"=>[853, 0, 0, 1]}

# ----------------------------------------------------------------------------------
# ロジックにより必要アイテムを配置

puts "ロケーションシャッフル前"
print items_placement_list
puts

# ロケーションシャッフル
shuffle_items_location = items_placement_list.shuffle

puts "ロケーションシャッフル後"
print shuffle_items_location
puts

# アイテム配置リスト
# ロケーション数ぶん二次元配列を作成
items_placement_list = Array.new(items_placement_list.size) { Array.new(4,0) }
puts "ロケーション数："
puts items_placement_list.size
puts "アイテム配置リスト："
p items_placement_list

# ファイル名結合用に設定
directory_path = directory + "/"

# 異種族のオーブ配置
items_placement_list[0][0] = (directory_path + shuffle_items_location[0][0]).gsub(/\\/){'/'} # マップファイル名
items_placement_list[0][1] = shuffle_items_location[0][1] # ロケーションパス
items_placement_list[0][2] = shuffle_items_location[0][2] # 必要アイテム
items_placement_list[0][3] = heterogeneous_orbs # アイテム情報

puts "必要アイテム：" + items_placement_list[0][2]

if items_placement_list[0][2] == "Nothing"
  puts "必要アイテム無し"

else # 必要アイテム有りルート
  puts "必要アイテム有り"

  if items_placement_list[0][2] == "The_key_to_the_coastal_shrine_maiden"
    # ☆海岸巫女の鍵必要ルート
    1.upto(items_placement_list.size-1) do |i|
      puts "必要アイテム[1階層]：" + shuffle_items_location[i][2]

      if shuffle_items_location[i][2] == "The_key_to_the_coastal_shrine_maiden"

      elsif shuffle_items_location[i][2] == "Nothing"
        # ☆海岸巫女の鍵だけ必要
        items_placement_list[1][0] = (directory_path + shuffle_items_location[i][0]).gsub(/\\/){'/'} # マップファイル名
        items_placement_list[1][1] = shuffle_items_location[i][1] # ロケーションパス
        items_placement_list[1][2] = shuffle_items_location[i][2] # 必要アイテム
        items_placement_list[1][3] = the_key_to_the_coastal_shrine_maiden # アイテム情報
        break

      elsif shuffle_items_location[i][2] == "Sunken_ship_key"
        # ☆沈没船の鍵も必要
        items_placement_list[1][0] = (directory_path + shuffle_items_location[i][0]).gsub(/\\/){'/'} # マップファイル名
        items_placement_list[1][1] = shuffle_items_location[i][1] # ロケーションパス
        items_placement_list[1][2] = shuffle_items_location[i][2] # 必要アイテム
        items_placement_list[1][3] = the_key_to_the_coastal_shrine_maiden # アイテム情報

        # ☆沈没船の鍵を配置
        (i + 1).upto(items_placement_list.size-1) do |j|
          puts "必要アイテム[2階層]：" + shuffle_items_location[j][2]

          if shuffle_items_location[j][2] == "Nothing"
            items_placement_list[2][0] = (directory_path + shuffle_items_location[j][0]).gsub(/\\/){'/'} # マップファイル名
            items_placement_list[2][1] = shuffle_items_location[j][1] # ロケーションパス
            items_placement_list[2][2] = shuffle_items_location[j][2] # 必要アイテム
            items_placement_list[2][3] = sunken_ship_key # アイテム情報
            break

          else

          end
        end

        break

      else

      end
    end

  elsif items_placement_list[0][2] == "Sunken_ship_key"
    # ☆沈没船の鍵必要ルート
    1.upto(items_placement_list.size-1) do |i|
      puts "必要アイテム[1階層]：" + shuffle_items_location[i][2]

      if shuffle_items_location[i][2] == "Sunken_ship_key"

      elsif shuffle_items_location[i][2] == "Nothing"
        # ☆沈没船の鍵だけ必要
        items_placement_list[1][0] = (directory_path + shuffle_items_location[i][0]).gsub(/\\/){'/'} # マップファイル名
        items_placement_list[1][1] = shuffle_items_location[i][1] # ロケーションパス
        items_placement_list[1][2] = shuffle_items_location[i][2] # 必要アイテム
        items_placement_list[1][3] = sunken_ship_key # アイテム情報
        break

      elsif shuffle_items_location[i][2] == "The_key_to_the_coastal_shrine_maiden"
        # ☆海岸巫女の鍵も必要
        items_placement_list[1][0] = (directory_path + shuffle_items_location[i][0]).gsub(/\\/){'/'} # マップファイル名
        items_placement_list[1][1] = shuffle_items_location[i][1] # ロケーションパス
        items_placement_list[1][2] = shuffle_items_location[i][2] # 必要アイテム
        items_placement_list[1][3] = sunken_ship_key # アイテム情報

        # ☆海岸巫女の鍵を配置
        (i + 1).upto(items_placement_list.size-1) do |j|
          puts "必要アイテム[2階層]：" + shuffle_items_location[j][2]

          if shuffle_items_location[j][2] == "Nothing"
            items_placement_list[2][0] = (directory_path + shuffle_items_location[j][0]).gsub(/\\/){'/'} # マップファイル名
            items_placement_list[2][1] = shuffle_items_location[j][1] # ロケーションパス
            items_placement_list[2][2] = shuffle_items_location[j][2] # 必要アイテム
            items_placement_list[2][3] = the_key_to_the_coastal_shrine_maiden # アイテム情報
            break

          else

          end
        end

        break

      else

      end
    end
  else
    print "異常です"
  end
end

puts "アイテム配置リスト："
p items_placement_list

# ----------------------------------------------------------------------------------
# アイテム一覧読み込み

# アイテム数
item_total = 0

# アイテム数取得
filename.each { |i|
  File.open(i, "r") do |file|
    hash = JSON.load(file)
    hash["@events"].each_with_index { |file_events, j|
      file_events[1]["@pages"].each_with_index { |file_pages, k|
        file_events[1]["@pages"][k]["@list"].each_with_index{ |file_list, l|
          if (file_events[1]["@pages"][k]["@list"][l]["@code"] == 126 \
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
items = Array.new(item_total) { Array.new(3,0) }
# p items
items_num = 0

# アイテム一覧読み込み
filename.each { |i|
  File.open(i, "r") do |file|
    hash = JSON.load(file)

    # puts("File:#{i}")

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
          if (file_events[1]["@pages"][k]["@list"][l]["@code"] == 126 \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 127 \
          || file_events[1]["@pages"][k]["@list"][l]["@code"] == 128) \
          && file_events[1]["@pages"][k]["@list"][l]["@parameters"][1] == 0
            # puts file_events[1]["@pages"][k]["@list"][l]["@parameters"][0]
            items[items_num][0] = "#{i}" # マップファイル名
            items[items_num][1] = "hash[\"@events\"][\"#{file_events[0]}\"][\"@pages\"][#{k}][\"@list\"][#{l}]" # ロケーションパス
            items[items_num][2] = file_events[1]["@pages"][k]["@list"][l] # アイテム情報
            items_num += 1
          end
        }

      }

    }

  end
}

puts "シャッフル前"
# print items
puts

# アイテム一覧シャッフル
shuffle_items = items.shuffle

puts "シャッフル後"
# print shuffle_items
puts

# シャッフルアイテム一覧
shuffle_items_num = 0

# ----------------------------------------------------------------------------------
# 残りのアイテム配置リストを埋めていく
items_placement_list.each_with_index do |list,i|
  if items_placement_list[i][0] == 0
    items_placement_list[i][0] = (directory_path + shuffle_items_location[i][0]).gsub(/\\/){'/'} # マップファイル名
    items_placement_list[i][1] = shuffle_items_location[i][1] # ロケーションパス
    items_placement_list[i][3] = shuffle_items[shuffle_items_num][2] # アイテム情報
    shuffle_items_num += 1
  end
end

puts "アイテム配置リスト全部埋めた："
p items_placement_list

# ----------------------------------------------------------------------------------
# ファイルに書き込んでいく

# パーティ解放フラグカウンタ
shuffle_party_num = 0

# アイテム一覧書き出し
items_placement_list.each_with_index { |i,j|
  # 何故かr+で実施したら末尾に追記の挙動になった
  # そのため別途wで書き込む形にしている
  filepath = "#{i[0]}"
  puts filepath

  File.open(filepath, "r") do |file2|
    hash = JSON.load(file2)

    puts "変更前"
    puts eval("#{i[1]}")

    puts "変更値"
    puts "#{i[3]}"

    # evalは文字列を変数に変える
    eval("#{i[1]} = #{i[3]}")

    puts "変更後"
    puts eval("#{i[1]}")
    puts

    shuffle_party_num += 1

    # ファイル出力
    File.open(filepath, "w") do |file3|

      hash_format = JSON.pretty_generate(hash)

      file3.write(hash_format)

    end

  end
}

# スポイラー作成
spoiler_text = directory + "/@spoiler.txt"

File.open(spoiler_text, "w") do |file|

  file.puts("★異種族のオーブ")
  file.puts("マップ名：" + items_placement_list[0][0])
  file.puts("配置場所：" + items_placement_list[0][1])
  file.puts("必要アイテム：" + items_placement_list[0][2])
  file.puts("")

  if items_placement_list[0][2] == "The_key_to_the_coastal_shrine_maiden"
    file.puts("☆海岸巫女の鍵")
    file.puts("マップ名：" + items_placement_list[1][0])
    file.puts("配置場所：" + items_placement_list[1][1])
    file.puts("必要アイテム：" + items_placement_list[1][2])
    file.puts("")

  elsif items_placement_list[0][2] == "Sunken_ship_key"
    file.puts("☆沈没船の鍵")
    file.puts("マップ名：" + items_placement_list[1][0])
    file.puts("配置場所：" + items_placement_list[1][1])
    file.puts("必要アイテム：" + items_placement_list[1][2])
    file.puts("")

  end

  if items_placement_list[1][2] == "The_key_to_the_coastal_shrine_maiden"
    file.puts("☆海岸巫女の鍵")
    file.puts("マップ名：" + items_placement_list[2][0])
    file.puts("配置場所：" + items_placement_list[2][1])
    file.puts("必要アイテム：" + items_placement_list[2][2])
    file.puts("")

  elsif items_placement_list[1][2] == "Sunken_ship_key"
    file.puts("☆沈没船の鍵")
    file.puts("マップ名：" + items_placement_list[2][0])
    file.puts("配置場所：" + items_placement_list[2][1])
    file.puts("必要アイテム：" + items_placement_list[2][2])
    file.puts("")

  end

end

puts "処理を終了します"
sleep 3
