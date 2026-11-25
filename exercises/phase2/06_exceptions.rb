# frozen_string_literal: true

# Phase 2-6: 例外処理の設計 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase2/06_exceptions.rb
#   docker compose exec app bundle exec rubocop exercises/phase2/06_exceptions.rb

# 1. カスタム例外クラス（StandardError を継承する）
# TODO: InsufficientFundsError と TemporaryNetworkError を定義してください
class InsufficientFundsError < StandardError
end

class TemporaryNetworkError < StandardError
end

# 2. 例外の送出
# - amount <= 0 の場合: ArgumentError ('引き出し額は正の数を指定してください') を raise
# - amount > balance の場合: InsufficientFundsError ('残高が不足しています') を raise
# - それ以外: balance - amount を返す
def withdraw(balance, amount)
  # TODO: 実装してください
  raise ArgumentError, '引き出し額は正の数を指定してください' if amount <= 0
  raise InsufficientFundsError, '残高が不足しています' if amount > balance

  balance - amount
end

# 3. ensure によるクリーンアップ（メソッド内では begin を省略できる）
# - '接続オープン' を puts
# - yield を実行してその戻り値を返す
# - 例外が起きても起きなくても、必ず ensure で '接続クローズ' を puts する
def with_connection
  # TODO: 実装してください
  puts '接続オープン'
  yield
ensure
  puts '接続クローズ'
end

# 4. retry を使ったリトライ処理
# - attempts = 0 で開始し、begin ブロック内で attempts += 1 してから yield(attempts) を呼ぶ
# - TemporaryNetworkError を rescue したら:
#   - attempts <= max_retries の間は retry する
#   - 上限を超えたら raise（引数なし）でそのまま再送出する
def fetch_with_retry(max_retries: 2)
  # TODO: 実装してください
  attempts = 0
  begin
    attempts += 1
    yield(attempts)
  rescue TemporaryNetworkError
    retry if attempts <= max_retries
    raise # 引数なしで元の例外を再送出！
  end
end

# --- 動作確認用コード ---
puts '=== 1. カスタム例外と withdraw ==='
p withdraw(1000, 400) # => 600
begin
  withdraw(1000, 1500)
rescue InsufficientFundsError => e
  puts "捕捉成功 (#{e.class}): #{e.message}"
end

puts "\n=== 2. ensure によるクリーンアップ ==="
begin
  with_connection do
    puts '処理中...'
    raise '途中でエラー発生'
  end
rescue RuntimeError => e
  puts "外側で捕捉: #{e.message}"
end

puts "\n=== 3. retry (3回目で成功するケース) ==="
result = fetch_with_retry(max_retries: 2) do |attempt|
  puts "試行 #{attempt} 回目"
  raise TemporaryNetworkError, '一時的なタイムアウト' if attempt < 3

  'データ取得成功!'
end
p result # => "データ取得成功!"

puts "\n=== 4. retry 上限超過 (再送出されるケース) ==="
begin
  fetch_with_retry(max_retries: 1) do |attempt|
    puts "試行 #{attempt} 回目"
    raise TemporaryNetworkError, 'ずっと繋がらない'
  end
rescue TemporaryNetworkError => e
  puts "最終的に失敗 (#{e.class}): #{e.message}"
end
