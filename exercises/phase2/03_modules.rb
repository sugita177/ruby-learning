# frozen_string_literal: true

# Phase 2-3: モジュールとメソッド探索経路 ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase2/03_modules.rb
#   docker compose exec app bundle exec rubocop exercises/phase2/03_modules.rb

# 1. include 用モジュール（インスタンスメソッドとして組み込む）
# - formatted_price: "#{price}円" を返す
module PriceFormatter
  # TODO: formatted_price を実装してください
  def formatted_price
    "#{price}円"
  end
end

# 2. extend 用モジュール（クラスメソッドとして組み込む）
# - description: "Class: #{name}" を返す（クラス上で呼ばれると name はクラス名になります）
module ClassInfo
  # TODO: description を実装してください
  def description
    "Class: #{name}"
  end
end

# 3. 名前空間としてのモジュール (Inventory::Item)
module Inventory
  class Item
    # TODO: PriceFormatter を include し、ClassInfo を extend してください
    include PriceFormatter
    extend ClassInfo

    attr_reader :name, :price

    def initialize(name, price)
      @name = name
      @price = price
    end
  end
end

# 4. prepend 用モジュール（元メソッドをラップする）
# - process(amount):
#   1. "[AUDIT] start: #{amount}" を puts で出力
#   2. result = super で元クラスの process(amount) を呼び出す
#   3. "[AUDIT] done: #{result}" を puts で出力
#   4. result を返す
module AuditLog
  # TODO: process(amount) を実装してください
  def process(amount)
    puts "[AUDIT] start: #{amount}"
    result = super
    puts "[AUDIT] done: #{result}"
    result
  end
end

class PaymentService
  # TODO: AuditLog を prepend してください
  prepend AuditLog

  def process(amount)
    (amount * 1.1).round
  end
end

# --- 動作確認用コード ---
puts '=== 1. 名前空間 + include + extend ==='
item = Inventory::Item.new('Keyboard', 12_000)
p item.formatted_price        # => "12000円"
p Inventory::Item.description # => "Class: Inventory::Item"

puts "\n=== 2. prepend + super ==="
service = PaymentService.new
p service.process(1000) # => [AUDIT] 出力のあと 1100 が返る

puts "\n=== 3. メソッド探索経路 (ancestors) ==="
p PaymentService.ancestors
# => [AuditLog, PaymentService, Object, Kernel, BasicObject]
