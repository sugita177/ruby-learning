# frozen_string_literal: true

# Phase 3-4: 値オブジェクトの表現 (Struct / Data) ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase3/04_value_objects.rb
#   docker compose exec app bundle exec rubocop exercises/phase3/04_value_objects.rb

# 1. Struct（ミュータブルな構造体）
# - フィールド: :title, :done
# - ブロック内に以下を定義してください:
#   - complete!: self.done = true で完了状態に書き換える
#   - status_label: done が true なら "[x] #{title}"、false なら "[ ] #{title}" を返す
Task = Struct.new(:title, :done) do
  # TODO: complete! と status_label を実装してください
  def complete!
    self.done = true
  end

  def status_label
    done ? "[x] #{title}" : "[ ] #{title}"
  end
end

# 2. Data.define（イミュータブルな値オブジェクト）
# - フィールド: :host, :port, :ssl
# - ブロック内に以下を定義してください:
#   - base_url: ssl が true なら 'https'、false なら 'http' を使って "#{scheme}://#{host}:#{port}" を返す
#   - secure_copy(new_port = 443): with を使って ssl: true, port: new_port に変更した新しい ServerConfig を返す
ServerConfig = Data.define(:host, :port, :ssl) do
  # TODO: base_url と secure_copy を実装してください
  def base_url
    scheme = ssl ? 'https' : 'http'
    "#{scheme}://#{host}:#{port}"
  end

  def secure_copy(new_port = 443)
    with(ssl: true, port: new_port)
  end
end

# --- 動作確認用コード ---
puts '=== 1. Struct (ミュータブル) ==='
task = Task.new('Write Ruby', false)
p task.status_label # => "[ ] Write Ruby"
task.complete!
p task.status_label # => "[x] Write Ruby"

puts "\n=== 2. Data.define (イミュータブル) ==="
dev_cfg = ServerConfig.new(host: 'localhost', port: 3000, ssl: false)
p dev_cfg.base_url  # => "http://localhost:3000"
p dev_cfg.frozen?   # => true

prod_cfg = dev_cfg.secure_copy(8443)
p prod_cfg.base_url # => "https://localhost:8443"
p dev_cfg.base_url  # => "http://localhost:3000" (元は変わらない！)

puts "\n=== 3. 値比較 (==) とパターンマッチ連携 ==="
p dev_cfg == ServerConfig.new('localhost', 3000, false) # => true

# TODO: prod_cfg から 1行パターンマッチ (=>) で host と port を取り出して表示してみてください
prod_cfg => { host:, port: }
p [host, port] # => ["localhost", 8443]
