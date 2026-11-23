# frozen_string_literal: true

# Phase 1-5: 式としての制御構文と真偽値 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/05_control_flow.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/05_control_flow.rb

# 1. 式としての case ... when（範囲 Range マッチ）
# - 200..299 => 'success'
# - 300..399 => 'redirect'
# - 400..499 => 'client_error'
# - 500..599 => 'server_error'
# - それ以外 => 'unknown'
def classify_http_status(code)
  # TODO: case 文の戻り値をそのまま返してください
  case code
  when 200..299 then 'success'
  when 300..399 then 'redirect'
  when 400..499 then 'client_error'
  when 500..599 then 'server_error'
  else 'unknown'
  end
end

# 2. Ruby の真偽値判定
# - value が Ruby 的に真なら true、偽（false / nil）なら false を返す
# ヒント: !!value（二重否定）または三項演算子で書けます
def truthy?(value)
  # TODO: 実装してください
  !!value
end

# 3. 後置 unless によるガード節
# - active が偽なら、後置 unless を使って早期リターンで nil を返す
# - active が真なら "[NOTIFY] #{message}" を返す
def notify_if_active(message, active: true)
  # TODO: 実装してください
  return nil unless active

  "[NOTIFY] #{message}"
end

# 4. nil 安全演算子 (&.)
# - email が nil でなければ前後空白削除(strip)して小文字化(downcase)する
# - email が nil ならエラーを出さず nil を返す
# ヒント: &. をメソッドチェーンで繋げます
def normalize_email(email)
  # TODO: 実装してください
  email&.strip&.downcase
end

# 5. ||= イディオム
# - ハッシュ config の :timeout が未設定(nil)なら 30 を、:retries が未設定なら 3 を代入して config を返す
def apply_default_config(config)
  # TODO: ||= を使って実装してください
  config[:timeout] ||= 30
  config[:retries] ||= 3
  config
end

# --- 動作確認用コード ---
puts '=== 1. case によるステータス分類 ==='
p classify_http_status(200) # => "success"
p classify_http_status(301) # => "redirect"
p classify_http_status(404) # => "client_error"
p classify_http_status(503) # => "server_error"
p classify_http_status(999) # => "unknown"

puts "\n=== 2. Ruby の真偽値 ==="
p truthy?(0)     # => true  (他言語と違い 0 は真！)
p truthy?('')    # => true  (空文字も真！)
p truthy?([])    # => true  (空配列も真！)
p truthy?(false) # => false
p truthy?(nil)   # => false

puts "\n=== 3. 後置 unless ==="
p notify_if_active('Deploy succeeded')                # => "[NOTIFY] Deploy succeeded"
p notify_if_active('Deploy skipped', active: false)   # => nil

puts "\n=== 4. nil 安全演算子 (&.) ==="
p normalize_email('  Alice@Example.COM ') # => "alice@example.com"
p normalize_email(nil)                    # => nil

puts "\n=== 5. ||= イディオム ==="
p apply_default_config({})                        # => {timeout: 30, retries: 3}
p apply_default_config({ timeout: 60 })           # => {timeout: 60, retries: 3}
p apply_default_config({ timeout: 5, retries: 0 }) # => {timeout: 5, retries: 0} (0 は真なので上書きされない！)
