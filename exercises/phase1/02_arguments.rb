# frozen_string_literal: true

# Phase 1-2: 引数のバリエーション ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/02_arguments.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/02_arguments.rb

# 1. デフォルト引数（呼び出しごとの再評価を確認）
# - 第2引数 list のデフォルト値を空配列 [] にする
# - list に tag を追加して list を返す（ヒント: list << tag）
def append_tag(tag, list = [])
  # TODO: 実装してください
  list << tag
end

# 2. キーワード引数（必須 + デフォルト付き）
# - host: 必須キーワード引数
# - path: デフォルト '/'
# - ssl: デフォルト true
# - ssl が true なら 'https'、false なら 'http' を使って "#{scheme}://#{host}#{path}" を返す
def build_url(host:, path: '/', ssl: true)
  # TODO: 実装してください
  scheme = ssl ? 'https' : 'http'
  "#{scheme}://#{host}#{path}"
end

# 3. 可変長引数（*args / **kwargs）
# - level: シンボル（例: :info, :error）
# - *messages: 0個以上のメッセージ文字列
# - **meta: 任意のメタ情報（キーワード引数）
# - meta が空なら: "[#{level.upcase}] #{body}" を返す（body は messages を ' ' で結合）
# - meta があるなら: "[#{level.upcase}] #{body} (#{meta_str})" を返す
#   ヒント: meta.map { |k, v| "#{k}=#{v}" }.join(' ')
def format_log(level, *messages, **meta)
  body = messages.join(' ')
  base = "[#{level.upcase}] #{body}"
  return base if meta.empty?

  meta_str = meta.map { |k, v| "#{k}=#{v}" }.join(' ')
  "#{base} (#{meta_str})"
end

# 4. 引数転送（...）
# - 受け取ったすべての引数をそのまま build_url に転送し、
#   "[URL] #{url}" の形式で返すラッパーメソッドを実装する
def build_labeled_url(...)
  url = build_url(...)
  "[URL] #{url}"
end

# --- 動作確認用コード ---
puts '=== 1. デフォルト引数の再評価 ==='
p append_tag('ruby')           # => ["ruby"]
p append_tag('rails')          # => ["rails"] (1回目の 'ruby' は混ざらない)
my_list = ['docker']
p append_tag('ruby', my_list)  # => ["docker", "ruby"]

puts "\n=== 2. キーワード引数 & ショートハンド & **展開 ==="
p build_url(host: 'example.com') # => "https://example.com/"
p build_url(host: 'localhost', path: '/api', ssl: false) # => "http://localhost/api"

# TODO: 下の 2 行のコメントを外し、変数を使ったショートハンド(host:, path:)と **options 展開で呼んでみてください
host = 'ruby-lang.org'
path = '/ja/'
p build_url(host:, path:)

options = { host: 'github.com', path: '/features', ssl: true }
p build_url(**options)

puts "\n=== 3. 可変長引数 ==="
p format_log(:info, 'server', 'started')
# => "[INFO] server started"
p format_log(:error, 'connection', 'failed', code: 500, host: 'db-1')
# => "[ERROR] connection failed (code=500 host=db-1)"

puts "\n=== 4. 引数転送 (...) ==="
p build_labeled_url(host: 'example.com', path: '/docs')
# => "[URL] https://example.com/docs"
