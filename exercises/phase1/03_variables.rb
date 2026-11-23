# frozen_string_literal: true

# Phase 1-3: 変数スコープとプレフィックス ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase1/03_variables.rb
#   docker compose exec app bundle exec rubocop exercises/phase1/03_variables.rb

# 1. 定数と .freeze
# TODO: サポートする通貨の定数 SUPPORTED_CURRENCIES を定義し、
# ['JPY', 'USD'] の配列を .freeze で変更不可にしてください
# （ヒント: Ruby では定数配列に .freeze を付けるのが定番イディオムです）
SUPPORTED_CURRENCIES = %w[JPY USD].freeze

# 簡単なウォレットを表すクラス
class Wallet
  # TODO: クラス内の定数 DEFAULT_CURRENCY に 'JPY' を設定してください
  DEFAULT_CURRENCY = 'JPY'

  # コンストラクタ（new 時に自動で呼ばれるメソッド）
  def initialize(owner, balance = 0)
    # TODO: インスタンス変数 @owner と @balance に引数を代入してください
    @owner = owner
    @balance = balance
  end

  def deposit(amount)
    # TODO: @balance に amount を加算し、加算後の @balance を返してください
    @balance += amount
  end

  def summary
    # TODO: "#{@owner}: #{@balance} #{DEFAULT_CURRENCY}" の形式で文字列を返してください
    "#{@owner}: #{@balance} #{DEFAULT_CURRENCY}"
  end

  def memo
    # 未代入のインスタンス変数を参照するとエラーにならず nil が返る確認用
    @memo
  end
end

# 2. ローカル変数のスコープ確認用メソッド
# TODO: 引数 rate を受け取り、amount * rate を返す calculate_tax(amount, rate) を定義してください
# （ヒント: トップレベルのローカル変数 tax_rate は def の壁を越えられないため、引数で受け取る必要があります）
def calculate_tax(amount, rate)
  amount * rate
end

# --- 動作確認用コード ---
puts '=== 1. 定数と .freeze ==='
p SUPPORTED_CURRENCIES # => ["JPY", "USD"]
p SUPPORTED_CURRENCIES.frozen? # => true

puts "\n=== 2. インスタンス変数 (@) ==="
alice_wallet = Wallet.new('Alice', 1000)
bob_wallet = Wallet.new('Bob')

alice_wallet.deposit(500)
p alice_wallet.summary # => "Alice: 1500 JPY"
p bob_wallet.summary   # => "Bob: 0 JPY"（インスタンスごとに @balance は独立）
p alice_wallet.memo    # => nil（未代入でもエラーにならない）

puts "\n=== 3. ローカル変数のスコープ ==="
if true
  inside_if = 'if の中で定義した変数'
end
# TODO: 下の行のコメントを外し、if の外でも inside_if が参照できることを確認してください
p inside_if

tax_rate = 0.1
# TODO: calculate_tax を定義できたら、下のコメントを外して実行してください
p calculate_tax(1000, tax_rate) # => 100.0
