# frozen_string_literal: true

# Phase 3-1: Enumerable による宣言的データ処理 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase3/01_enumerable.rb
#   docker compose exec app bundle exec rubocop exercises/phase3/01_enumerable.rb

# 1. select + map（または filter_map）
# - active: true のユーザーだけを抽出し、その :email を配列で返す
def active_user_emails(users)
  # TODO: 実装してください
  users.select { it[:active] }.map { it[:email] }
end

# 2. group_by
# - users を :role ごとにグループ化したハッシュを返す
def group_by_role(users)
  # TODO: 実装してください
  users.group_by { it[:role] }
end

# 3. tally
# - ステータスコードの配列から、各コードの出現回数をハッシュで返す
def count_statuses(codes)
  # TODO: 実装してください
  codes.tally
end

# 4. each_with_object
# - users から { id => name } のハッシュを構築して返す
def index_by_id(users)
  # TODO: each_with_object({}) を使って実装してください
  users.to_h { [it[:id], it[:name]] }
end

# 5. 自作クラスを Enumerable にする
# - Enumerable を include し、each メソッドを実装する（@songs.each(&block)）
class Playlist
  # TODO: Enumerable を include してください
  include Enumerable

  def initialize(songs)
    @songs = songs
  end

  # TODO: def each(&block) を実装してください
  def each(&)
    @songs.each(&)
  end
end

# --- 動作確認用コード ---
users = [
  { id: 1, name: 'Alice', role: 'admin',  active: true,  email: 'alice@example.com' },
  { id: 2, name: 'Bob',   role: 'member', active: false, email: 'bob@example.com' },
  { id: 3, name: 'Carol', role: 'member', active: true,  email: 'carol@example.com' }
]

puts '=== 1. active_user_emails ==='
p active_user_emails(users) # => ["alice@example.com", "carol@example.com"]

puts "\n=== 2. group_by_role ==="
p(group_by_role(users).transform_values { |list| list.map { |u| u[:name] } })
# => {"admin" => ["Alice"], "member" => ["Bob", "Carol"]}

puts "\n=== 3. count_statuses ==="
p count_statuses([200, 404, 200, 500, 200, 404]) # => {200 => 3, 404 => 2, 500 => 1}

puts "\n=== 4. index_by_id ==="
p index_by_id(users) # => {1 => "Alice", 2 => "Bob", 3 => "Carol"}

puts "\n=== 5. 自作 Enumerable (Playlist) ==="
playlist = Playlist.new(['Song A', 'Song B', 'Track C'])
p(playlist.select { |s| s.start_with?('Song') }) # => ["Song A", "Song B"]
p playlist.map(&:upcase)                        # => ["SONG A", "SONG B", "TRACK C"]
p playlist.count                                # => 3
