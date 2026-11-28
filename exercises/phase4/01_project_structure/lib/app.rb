# frozen_string_literal: true

# TODO: 同じディレクトリにある greeter.rb を require_relative で読み込んでください
require_relative 'greeter'

module App
  def self.run(name)
    # TODO: Greeter.new(name).to_json の結果を puts で出力してください
    puts Greeter.new(name).to_json
  end
end
