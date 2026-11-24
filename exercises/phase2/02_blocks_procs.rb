# frozen_string_literal: true

# Phase 2-2: ブロック・Proc・Lambda ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase2/02_blocks_procs.rb
#   docker compose exec app bundle exec rubocop exercises/phase2/02_blocks_procs.rb

# 1. yield と block_given?
# - ブロックが渡されていない場合は 'no block' を返す（unless block_given?）
# - "[START] #{label}" を puts で出力
# - yield でブロックを実行し、その戻り値を変数 result に保持
# - "[END] #{label}" を puts で出力
# - result を返す
def with_timing(label)
  # TODO: 実装してください
  return 'no block' unless block_given?

  puts "[START] #{label}"
  result = yield(label)
  puts "[END] #{label}"
  result
end

# 2. Lambda（クロージャ）を返すメソッド
# - 引数 n を受け取り n * factor を返す Lambda (->(n) { ... }) を生成して返す
def build_multiplier(factor)
  # TODO: 実装してください
  ->(n) { n * factor }
end

# 3. Symbol#to_proc (&:メソッド名)
# - 文字列配列 words の各要素の文字数(length)の配列を返す
# ヒント: words.map(&:length) のように 1 行で書けます
def extract_lengths(words)
  # TODO: 実装してください
  words.map(&:length)
end

# 4. Proc と Lambda の return 挙動の違い
# - run_with_lambda: -> { return :from_lambda } を定義して .call し、最後に :after_lambda を返す
# - run_with_proc:   proc { return :from_proc } を定義して .call し、最後に :after_proc を書く
def run_with_lambda
  # TODO: 実装してください
  (-> { return :from_lambda }).call
  :after_lambda
end

def run_with_proc
  # TODO: 実装してください
  (proc { return :from_proc }).call
  :after_proc
end

# --- 動作確認用コード ---
puts '=== 1. yield と block_given? ==='
p with_timing('empty') # => "no block"
res = with_timing('calc') do
  10 + 20
end
p res # => 30

puts "\n=== 2. Lambda (クロージャ) ==="
double = build_multiplier(2)
triple = build_multiplier(3)
p double.call(5) # => 10
p triple.call(5) # => 15

puts "\n=== 3. &:メソッド名 ==="
p extract_lengths(%w[ruby python javascript]) # => [4, 6, 10]

puts "\n=== 4. Proc vs Lambda の return ==="
p run_with_lambda # => :after_lambda (Lambda 自身からだけ抜ける)
p run_with_proc   # => :from_proc   (Proc を囲むメソッドごと抜ける)
