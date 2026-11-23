# frozen_string_literal: true

# Phase 1-4: 文字列・配列・ハッシュのリテラルと記法 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/04_literals.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/04_literals.rb

# 1. %w と %i 記法
# TODO: %w を使って文字列の配列 ['ruby', 'python', 'javascript', 'php'] を定義してください
SUPPORTED_LANGUAGES = %w[ruby python javascript php].freeze

# TODO: %i を使ってシンボルの配列 [:read, :write, :execute] を定義してください
PERMISSIONS = %i[read write execute].freeze

# 2. ヒアドキュメント (<<~) と式展開
# 以下の形式の複数行文字列を <<~TEXT ... TEXT を使って返してください（末尾改行ありでOK）:
#   Name: <name>
#   Role: <role>
#   Languages: <languagesを ', ' で結合した文字列>
def render_profile(name:, role:, languages:)
  # TODO: 実装してください
  <<~TEXT
    Name: #{name}
    Role: #{role}
    Languages: #{languages.join(', ')}
  TEXT
end

# 3. %q 記法
# TODO: %q(...) を使って、エスケープなしで次の文字列を返してください:
#   It's "Ruby" style!
def quote_example
  # TODO: 実装してください
  %q(It's "Ruby" style!)
end

# 4. ハッシュリテラル（ロケット記法と値省略記法）
# - headers にロケット記法を使って { 'Content-Type' => content_type } を代入する
# - 値省略記法（{ method:, path:, headers: }）を使ってハッシュを返す
def build_request(method, path, content_type)
  # TODO: 実装してください
  headers = { 'Content-Type' => content_type }
  { method:, path:, headers: }
end

# --- 動作確認用コード ---
puts '=== 1. %w / %i ==='
p SUPPORTED_LANGUAGES # => ["ruby", "python", "javascript", "php"]
p PERMISSIONS         # => [:read, :write, :execute]

puts "\n=== 2. <<~ ヒアドキュメント ==="
puts render_profile(name: 'Alice', role: 'admin', languages: %w[ruby python])

puts "\n=== 3. %q 記法 ==="
p quote_example # => "It's \"Ruby\" style!"

puts "\n=== 4. ハッシュ記法 ==="
p build_request(:post, '/api/users', 'application/json')
# => {method: :post, path: "/api/users", headers: {"Content-Type" => "application/json"}}
