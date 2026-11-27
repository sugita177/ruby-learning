# frozen_string_literal: true

# Phase 3-2: Enumerator と遅延評価 (lazy) ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase3/02_enumerator.rb
#   docker compose exec app bundle exec rubocop exercises/phase3/02_enumerator.rb

# 1. map.with_index(1)
# - lines の各行に 1 始まりの行番号を付けて ["1: line1", "2: line2", ...] を返す
def number_lines(lines)
  # TODO: map.with_index(1) を使って実装してください
  lines.map.with_index(1) do |line, index|
    "#{index}: #{line}"
  end
end

# 2. Enumerator.new で無限ジェネレータを作る
# - 2, 4, 6, 8, ... と正の偶数を無限に生成する Enumerator を返す
def even_numbers
  # TODO: Enumerator.new do |y| ... end を使って実装してください
  Enumerator.new do |y|
    i = 2
    loop do
      y << i
      i += 2
    end
  end
end

# 3. 終端なし Range (1..) と .lazy による遅延評価
# - (1..).lazy を使い、divisor で割り切れる整数を抽出(select)し、
#   それぞれを 2 乗(map)した値の先頭 count 件(first)を配列で返す
def first_n_squared_multiples(divisor, count)
  # TODO: 実装してください
  (1..).lazy.select { (it % divisor).zero? }.map { it * it }.first(count)
end

# 4. ログストリームからの遅延抽出
# - log_stream (Enumerator) に対して .lazy を使い、
#   'ERROR' を含む行 (include?('ERROR')) を先頭 limit 件だけ配列で返す
def extract_error_logs(log_stream, limit)
  # TODO: 実装してください
  log_stream.lazy.select { it.include?('ERROR') }.first(limit)
end

# --- 動作確認用コード ---
puts '=== 1. map.with_index(1) ==='
p number_lines(%w[alpha beta gamma])
# => ["1: alpha", "2: beta", "3: gamma"]

puts "\n=== 2. Enumerator.new (無限ジェネレータ) ==="
evens = even_numbers
p evens.next       # => 2
p evens.next       # => 4
p even_numbers.take(5) # => [2, 4, 6, 8, 10]

puts "\n=== 3. (1..).lazy ==="
p first_n_squared_multiples(3, 4) # => [9, 36, 81, 144] (3, 6, 9, 12 の2乗)

puts "\n=== 4. 遅延評価で必要最小限しか読まれないことを確認 ==="
read_count = 0
stream = Enumerator.new do |y|
  %w[INFO_1 ERROR_1 INFO_2 ERROR_2 INFO_3 ERROR_3].each do |line|
    read_count += 1
    y << line
  end
end

p extract_error_logs(stream, 2) # => ["ERROR_1", "ERROR_2"]
puts "読まれた行数: #{read_count} / 6" # => 4行目で打ち切られる！
