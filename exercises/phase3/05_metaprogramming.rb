# frozen_string_literal: true

# Phase 3-5: メタプログラミング入門 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase3/05_metaprogramming.rb
#   docker compose exec app bundle exec rubocop exercises/phase3/05_metaprogramming.rb

# 1. define_method によるメソッドの動的定義
class Order
  STATUSES = %i[pending paid shipped].freeze

  def initialize(status)
    @status = status
  end

  # TODO: STATUSES を each で回し、define_method を使って
  # pending?, paid?, shipped? メソッドを動的に定義してください
  # （各メソッドは @status == status を返す）
  STATUSES.each do |status|
    define_method("#{status}?") do
      @status == status
    end
  end
end

# 2. public_send による動的ディスパッチ
# - order に対して method_name を public_send で呼び出して返す
def check_order(order, method_name)
  # TODO: 実装してください
  order.public_send(method_name)
end

# 3. method_missing + respond_to_missing?
class DynamicConfig
  def initialize(data)
    @data = data
  end

  # TODO: @data に name キーがあれば @data[name] を返し、なければ super を呼ぶ method_missing を実装してください
  def method_missing(name, *args)
    return @data[name] if @data.key?(name)

    super
  end

  # TODO: @data.key?(name) || super を返す respond_to_missing?(name, include_private = false) を実装してください
  def respond_to_missing?(name, include_private = false)
    @data.key?(name) || super
  end
end

# 4. instance_eval を使ったミニ DSL
class AppDSL
  attr_reader :settings

  def initialize
    @settings = {}
  end

  def set(key, value)
    @settings[key] = value
  end
end

# - AppDSL.new を生成し、受け取ったブロックを instance_eval(&) で実行したあと、
#   dsl.settings を返す
def configure(&)
  # TODO: 実装してください
  dsl = AppDSL.new
  dsl.instance_eval(&)
  dsl.settings
end

# --- 動作確認用コード ---
puts '=== 1 & 2. define_method + public_send ==='
order = Order.new(:paid)
p order.pending?                # => false
p order.paid?                   # => true
p check_order(order, :shipped?) # => false

puts "\n=== 3. method_missing + respond_to_missing? ==="
cfg = DynamicConfig.new(host: 'localhost', port: 3000)
p cfg.host                  # => "localhost"
p cfg.port                  # => 3000
p cfg.respond_to?(:host)    # => true
p cfg.respond_to?(:unknown) # => false

begin
  cfg.unknown
rescue NoMethodError => e
  puts "期待通りエラー: #{e.message}"
end

puts "\n=== 4. instance_eval (ミニDSL) ==="
result = configure do
  set :app_name, 'MyRubyApp'
  set :workers, 4
end
p result # => {app_name: "MyRubyApp", workers: 4}
