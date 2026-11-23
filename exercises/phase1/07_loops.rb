# frozen_string_literal: true

# Phase 1-7: ループのイディオム ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/07_loops.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/07_loops.rb

# 1. times を使った繰り返し
# - count 回繰り返して ["[1] #{message}", "[2] #{message}", ...] の配列を返す
# ヒント: count.times { |i| ... } の i は 0 から始まります
def repeat_message(message, count)
  result = []
  # TODO: times を使って実装してください
  count.times { |i| result << "[#{i + 1}] #{message}" }
  result
end

# 2. each_with_index を使ったインデックス付き走査
# - items の各要素を "#{index + 1}. #{item}" の形式に変換した配列を返す
def format_menu(items)
  result = []
  # TODO: each_with_index を使って実装してください
  items.each_with_index { |item, index| result << "#{index + 1}. #{item}" }
  result
end

# 3. upto と next (continue 相当) を使った合計計算
# - from から to までの整数のうち、奇数だけの合計を返す
# ヒント: 偶数の判定は n.even? が使えます（next if n.even?）
def sum_odd_numbers(from, to)
  total = 0
  # TODO: upto と next を使って実装してください
  from.upto(to) do |n|
    next if n.even?

    total += n
  end
  total
end

# 4. loop と break 値 を使った探索
# - インデックス idx を 0 から増やしながら numbers を順番に調べ、
#   threshold より大きい最初の要素を見つけたら break でその値を返す
# - 最後まで見つからなければ break nil を返す
def find_first_over(numbers, threshold)
  idx = 0
  # TODO: loop do ... end を使って実装してください
  loop do
    break nil if idx == numbers.size

    break numbers[idx] if numbers[idx] > threshold

    idx += 1
  end
end

# --- 動作確認用コード ---
puts '=== 1. times ==='
p repeat_message('Hello', 3)
# => ["[1] Hello", "[2] Hello", "[3] Hello"]

puts "\n=== 2. each_with_index ==="
p format_menu(%w[Coffee Tea Juice])
# => ["1. Coffee", "2. Tea", "3. Juice"]

puts "\n=== 3. upto + next ==="
p sum_odd_numbers(1, 10) # => 25 (1 + 3 + 5 + 7 + 9)

puts "\n=== 4. loop + break 値 ==="
p find_first_over([10, 25, 40, 15], 20) # => 25
p find_first_over([1, 2, 3], 10)        # => nil
