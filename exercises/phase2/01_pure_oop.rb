# frozen_string_literal: true

# Phase 2-1: Pure OOP とオープンクラス / Refinements ハンズオン課題
#
# TODO の箇所を実装し、以下のコマンドで動作確認とスタイルチェックを行ってください。
#   docker compose exec app ruby exercises/phase2/01_pure_oop.rb
#   docker compose exec app bundle exec rubocop exercises/phase2/01_pure_oop.rb

# 1. Pure OOP の確認
# - obj のクラス名と、そのクラス自身のクラス名（Class）を配列 [obj.class, obj.class.class] で返す
def inspect_classes(obj)
  # TODO: 実装してください
  [obj.class, obj.class.class]
end

# 2. オープンクラス（Integer クラスを開いてメソッドを追加）
# - positive_even? メソッドを追加し、正の数(positive?)かつ偶数(even?)なら true を返す
class Integer
  # TODO: positive_even? を実装してください
  def positive_even?
    positive? && even?
  end
end

# 3. Refinements（スコープ限定の安全な拡張）
# - module StringMasking の中で refine String do ... end を定義する
# - String#mask(visible = 2):
#   - length <= visible なら self をそのまま返す
#   - それ以外は先頭 visible 文字を残し、残りを '*' で埋めた文字列を返す
#   ヒント: self[0, visible] と '*' * (length - visible) を組み合わせられます
module StringMasking
  # TODO: refine String do ... end を実装してください
  refine String do
    def mask(visible)
      return self if length <= visible

      self[0, visible] << ('*' * (length - visible))
    end
  end
end

# StringMasking を利用するプレゼンタークラス
class UserPresenter
  # TODO: using StringMasking を宣言してください
  using StringMasking

  def present_token(token)
    # TODO: token.mask(4) を呼び出して返してください
    token.mask(4)
  end
end

# --- 動作確認用コード ---
puts '=== 1. Pure OOP の確認 ==='
p inspect_classes(42)      # => [Integer, Class]
p inspect_classes('ruby')  # => [String, Class]
p inspect_classes(nil)     # => [NilClass, Class]
p 10.+(5)                  # => 15 (演算子もメソッド)

puts "\n=== 2. オープンクラス ==="
p 4.positive_even? # => true
p(-4.positive_even?) # => false
p 3.positive_even? # => false

puts "\n=== 3. Refinements ==="
presenter = UserPresenter.new
p presenter.present_token('abcdefgh') # => "abcd****"
p presenter.present_token('abc')      # => "abc"

puts "\n=== 4. Refinements の外では使えないことを確認 ==="
begin
  'abcdefgh'.mask(4)
rescue NoMethodError => e
  puts "期待通りエラー: #{e.message}"
end
