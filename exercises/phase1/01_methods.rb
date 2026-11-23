# frozen_string_literal: true

# Phase 1-1: メソッド定義と命名規則 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/01_methods.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/01_methods.rb
# 以下で、rubocopにて「Correctable]となっているものを自動で修正してくれる
#   docker compose exec app bundle exec rubocop -a exercises/phase1/01_methods.rb

# 1. 引数なしのメソッド（括弧を省略して定義）
# 期待値: "1.0.0" を返す
def app_version
  # TODO: 暗黙の戻り値を使って "1.0.0" を返してください
  '1.0.0'
end

# 2. 挨拶文を返すメソッド（早期リターン + 暗黙の戻り値）
# - name が nil または空文字("")の場合は、早期リターンで "Hello, Guest!" を返す
# - それ以外の場合は "Hello, #{name}!" を返す
# ヒント: name.nil? || name.empty? や後置 if が使えます
def format_greeting(name)
  # TODO: 実装してください
  return 'Hello, Guest!' if name.nil? || name.empty?

  "Hello, #{name}!"
end

# 3. 成人判定を行う述語メソッド（? 命名規則）
# - age が 20 以上なら true、それ以外は false を返す
# ヒント: Ruby では比較式そのものが true / false を返します
def adult?(age)
  # TODO: 実装してください
  age >= 20
end

# 4. タグ配列を正規化するメソッド（非破壊的: ! なし / 破壊的: ! あり）
# - 配列内の各文字列について、前後の空白を削除(strip)して小文字(downcase)にする
# - normalize_tags(tags) は元の配列を変更せず、新しい配列を返す
# - normalize_tags!(tags) は渡された配列そのものを書き換えて返す
# ヒント: Array#map と Array#map! を使うと簡潔に書けます（例: tags.map { |t| ... }）
def normalize_tags(tags)
  # TODO: 非破壊的メソッドを実装してください
  tags.map { |t| t.strip.downcase }
end

def normalize_tags!(tags)
  # TODO: 破壊的メソッドを実装してください
  tags.map! { |t| t.strip.downcase }
end

# --- 動作確認用コード（ここは変更せずそのまま実行してください） ---
puts '=== 1. app_version ==='
p app_version # => "1.0.0"

puts "\n=== 2. format_greeting ==="
p format_greeting('Alice') # => "Hello, Alice!"
p format_greeting('')      # => "Hello, Guest!"
p format_greeting(nil)     # => "Hello, Guest!"

puts "\n=== 3. adult? ==="
p adult?(20) # => true
p adult?(19) # => false

puts "\n=== 4. normalize_tags / normalize_tags! ==="
original = [' Ruby ', '  RAILS', 'docker ']
normalized = normalize_tags(original)
p normalized # => ["ruby", "rails", "docker"]
p original   # => [" Ruby ", "  RAILS", "docker "] (元の配列は変わらない)

normalize_tags!(original)
p original   # => ["ruby", "rails", "docker"] (元の配列が書き換わる)
