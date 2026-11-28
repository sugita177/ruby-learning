# frozen_string_literal: true

# TODO: 標準添付ライブラリ 'json' を require で読み込んでください
require 'json'

class Greeter
  def initialize(name)
    @name = name
  end

  # TODO: { message: "Hello, #{@name}!" } を JSON 文字列に変換して返す to_json メソッドを実装してください
  # （ヒント: JSON.generate(...) またはハッシュの .to_json が使えます）
  def to_json(*_args)
    # TODO: 実装してください
    { message: "Hello, #{@name}!" }.to_json
  end
end
