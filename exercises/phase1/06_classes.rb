# frozen_string_literal: true

# Phase 1-6: クラス定義とアクセサ ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/06_classes.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/06_classes.rb

# 商品を表す基底クラス
class Product
  # TODO: name は読み取り専用(attr_reader)、price は読み書き可能(attr_accessor)にしてください
  attr_reader :name
  attr_accessor :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  # 割引を適用するメソッド
  # - まず private メソッド validate_percent!(percent) を呼ぶ
  # - 割引後の価格を計算: (price * (100 - percent) / 100.0).round
  # - self.price = ... を使って価格を更新する（self. を忘れると更新されません！）
  def apply_discount(percent)
    # TODO: 実装してください
    validate_percent!(percent)
    self.price = (price * (100 - percent) / 100.0).round
  end

  # "#{name}: #{price}円" を返す
  def label
    # TODO: 実装してください
    "#{name}: #{price}円"
  end

  private

  # 割引率が 0..100 の範囲外なら ArgumentError を投げる
  def validate_percent!(percent)
    return if (0..100).cover?(percent)

    raise ArgumentError, '割引率は 0〜100 の範囲で指定してください'
  end
end

# デジタル商品を表すサブクラス（Product を継承）
class DigitalProduct < Product
  # TODO: file_size_mb を読み取り専用(attr_reader)にしてください
  attr_reader :file_size_mb

  # TODO: initialize(name, price, file_size_mb) を定義し、
  # super(name, price) で親クラスを初期化したあと @file_size_mb を設定してください
  def initialize(name, price, file_size_mb)
    super(name, price)
    @file_size_mb = file_size_mb
  end

  # 親クラスの label をオーバーライドする
  # - super で親の label ("名前: 価格円") を取得し、"#{super} (#{file_size_mb}MB)" を返す
  def label
    # TODO: 実装してください
    "#{super} (#{file_size_mb}MB)"
  end
end

# --- 動作確認用コード ---
puts '=== 1. Product 基本動作 ==='
book = Product.new('Ruby入門', 3000)
p book.name  # => "Ruby入門"
p book.price # => 3000
p book.label # => "Ruby入門: 3000円"

book.apply_discount(20)
p book.price # => 2400
p book.label # => "Ruby入門: 2400円"

puts "\n=== 2. private メソッドは外部から呼べない ==="
begin
  book.validate_percent!(10)
rescue NoMethodError => e
  puts "期待通りエラー: #{e.message}"
end

puts "\n=== 3. DigitalProduct (継承と super) ==="
ebook = DigitalProduct.new('実践Ruby電子版', 2000, 15)
p ebook.file_size_mb # => 15
p ebook.label        # => "実践Ruby電子版: 2000円 (15MB)"

ebook.apply_discount(50)
p ebook.label        # => "実践Ruby電子版: 1000円 (15MB)"
