# frozen_string_literal: true

# Phase 3-3: パターンマッチ (case ... in) ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase3/03_pattern_matching.rb
#   docker compose exec app bundle exec rubocop exercises/phase3/03_pattern_matching.rb

# 1. ネストしたハッシュの構造分解 + ガード条件 + 範囲マッチ
# - { status: 200, body: { user: { name:, role: 'admin' } } } => "Admin: #{name}"
# - { status: 200, body: { user: { name:, age: } } } (age >= 20) => "Adult: #{name}"
# - { status: 200, body: { user: { name: } } }                   => "User: #{name}"
# - { status: 400..599 => code, error: msg }                     => "Error #{code}: #{msg}"
# - それ以外                                                     => 'Unknown'
def parse_api_response(res)
  # TODO: case res ... in ... を使って実装してください
  case res
  in { status: 200, body: { user: { name:, role: 'admin' } } } then "Admin: #{name}"
  in { status: 200, body: { user: { name:, age: } } } if age >= 20 then "Adult: #{name}"
  in { status: 200, body: { user: { name: } } } then "User: #{name}"
  in { status: (400..599) => code, error: msg } then "Error #{code}: #{msg}"
  else 'Unknown'
  end
end

# 2. 配列パターンマッチ（完全一致と *rest）
# - ['help']              => 'Show help'
# - ['exec', cmd, *flags] => "Run #{cmd} (#{flags.size} flags)"
# - それ以外              => 'Invalid command'
def summarize_command(args)
  # TODO: case args ... in ... を使って実装してください
  case args
  in ['help']
    'Show help'
  in ['exec', cmd, *flags]
    "Run #{cmd} (#{flags.size} flags)"
  else
    'Invalid command'
  end
end

# 3. ピン演算子 (^) と 1行パターンマッチ (in)
# - config が { env: ^target_env, enabled: true } にマッチすれば true、そうでなければ false
def match_target_env?(config, target_env)
  # TODO: 1行パターンマッチ (in) とピン演算子 (^) で実装してください
  config in { env: ^target_env, enabled: true }
end

# 4. 1行パターンマッチ (=>) によるネストした値の取り出し
# - point ({ geo: { lat:, lng: } }) から lat と lng を取り出して [lat, lng] を返す
def extract_coordinates(point)
  # TODO: point => { ... } を使って実装してください
  point => { geo: { lat:, lng: } }
  [lat, lng]
end

# --- 動作確認用コード ---
puts '=== 1. parse_api_response ==='
p parse_api_response({ status: 200, body: { user: { name: 'Alice', role: 'admin', age: 30 } } })
# => "Admin: Alice"
p parse_api_response({ status: 200, body: { user: { name: 'Bob', role: 'member', age: 25 } } })
# => "Adult: Bob"
p parse_api_response({ status: 200, body: { user: { name: 'Carol', role: 'member', age: 17 } } })
# => "User: Carol"
p parse_api_response({ status: 503, error: 'Service Unavailable' })
# => "Error 503: Service Unavailable"
p parse_api_response({})
# => "Unknown"

puts "\n=== 2. summarize_command ==="
p summarize_command(['help']) # => "Show help"
p summarize_command(['exec', 'deploy', '-v', '-f']) # => "Run deploy (2 flags)"
p summarize_command([]) # => "Invalid command"

puts "\n=== 3. match_target_env? ==="
p match_target_env?({ env: :prod, enabled: true, region: 'ap-northeast-1' }, :prod) # => true
p match_target_env?({ env: :dev, enabled: true }, :prod)                            # => false

puts "\n=== 4. extract_coordinates ==="
p extract_coordinates({ city: 'Tokyo', geo: { lat: 35.68, lng: 139.76 } }) # => [35.68, 139.76]
