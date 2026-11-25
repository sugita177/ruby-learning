# frozen_string_literal: true

# Phase 2-5: シンボルと文字列のイミュータブル化 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase2/05_symbols_and_strings.rb
#   docker compose exec app bundle exec rubocop exercises/phase2/05_symbols_and_strings.rb

# 1. 同一オブジェクト（object_id が同じ）かどうかの判定
def same_object?(obj_a, obj_b)
  # TODO: object_id を比較して true / false を返してください
  # obj_a.object_id == obj_b.object_id
  obj_a.equal?(obj_b)
end

# 2. 文字列キーのハッシュをシンボルキーのハッシュに変換する
# - 例: { 'host' => 'localhost', 'port' => 8080 } => { host: 'localhost', port: 8080 }
# ヒント: Hash#transform_keys(&:to_sym) を使うと 1 行で書けます
def symbolize_keys(hash)
  # TODO: 実装してください
  hash.transform_keys(&:to_sym)
end

# 3. frozen_string_literal 環境でのミュータブルバッファ構築と freeze
# - 先頭行: "Items for #{owner}:\n" を単項プラス (+...) でミュータブル文字列として作る
# - items の各要素について "- #{item}\n" を << で破壊的に追記する
# - 最後に .freeze してイミュータブルな文字列として返す
def format_item_list(owner, items)
  # TODO: 実装してください
  # 式展開文字列は最初からミュータブル
  result = "Items for #{owner}:\n"
  items.each do |item|
    result << "- #{item}\n"
  end
  result.freeze
end

# --- 動作確認用コード ---
puts '=== 1. シンボルと freeze 文字列の object_id ==='
p same_object?(:ruby, 'ruby'.to_sym) # => true (シンボルは常に同一オブジェクト)
p same_object?('ruby', 'ruby')       # => true (frozen_string_literal: true のおかげ！)

puts "\n=== 2. symbolize_keys ==="
raw_config = { 'host' => 'localhost', 'port' => 8080 }
p symbolize_keys(raw_config) # => {host: "localhost", port: 8080}

puts "\n=== 3. ミュータブル文字列 (+...) と freeze ==="
list = format_item_list('Alice', %w[Book Pen])
puts list
p list.frozen? # => true

puts "\n=== 4. FrozenError の確認 ==="
begin
  'immutable'.upcase!
rescue FrozenError => e
  puts "期待通りエラー: #{e.message}"
end
