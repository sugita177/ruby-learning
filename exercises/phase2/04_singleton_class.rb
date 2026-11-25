# frozen_string_literal: true

# Phase 2-4: 特異メソッドと特異クラス ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase2/04_singleton_class.rb
#   docker compose exec app bundle exec rubocop exercises/phase2/04_singleton_class.rb

# 1. 特異メソッド用クラス
class Account
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# 2. class << self を使ったクラスメソッド定義
class AppConfig
  @env = :development

  class << self
    # TODO: env の読み書きができるよう attr_accessor :env を定義してください
    attr_accessor :env

    # TODO: env == :production なら true を返す production? メソッドを定義してください
    def production?
      env == :production
    end

    # TODO: reset! メソッドを定義し、private メソッド default_env を使って @env を戻してください
    def reset!
      @env = default_env
    end

    private

    def default_env
      :development
    end
  end
end

# 3. クラスインスタンス変数（サブクラスと独立することを確認）
class BaseTracker
  @count = 0

  class << self
    attr_reader :count

    # TODO: @count ||= 0 で初期化したうえで @count += 1 する increment! メソッドを実装してください
    # （ヒント: サブクラスには @count が自動継承されないため ||= 0 が重要です）
    def increment!
      @count ||= 0
      @count += 1
    end
  end
end

class OrderTracker < BaseTracker
end

# --- 動作確認用コード ---
puts '=== 1. 特異メソッド ==='
admin = Account.new('Alice')
guest = Account.new('Bob')

# TODO: admin オブジェクトだけに特異メソッド admin_badge を定義してください
# （期待値: "[ADMIN] #{name}" を返す）
def admin.admin_badge
  "[ADMIN] #{name}"
end

p admin.admin_badge # => "[ADMIN] Alice"
begin
  guest.admin_badge
rescue NoMethodError => e
  puts "guest は呼べない: #{e.message}"
end

puts "\n=== 2. class << self と private クラスメソッド ==="
p AppConfig.env         # => :development
p AppConfig.production? # => false
AppConfig.env = :production
p AppConfig.production? # => true
AppConfig.reset!
p AppConfig.env         # => :development

puts "\n=== 3. クラスインスタンス変数の独立性 ==="
OrderTracker.increment!
OrderTracker.increment!
p OrderTracker.count # => 2
p BaseTracker.count  # => 0 (@@count と違い親クラスに影響しない！)

puts "\n=== 4. singleton_class の確認 ==="
p admin.singleton_class
p admin.singleton_methods # => [:admin_badge]
