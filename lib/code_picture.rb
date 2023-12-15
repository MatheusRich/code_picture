# frozen_string_literal: true

require "nokogiri"
require "prism"
require "erb"
require_relative "theme"

class CodePicture
  IGNORED_TOKENS = %i[
    EOF
    IGNORED_NEWLINE
    NEWLINE
    WORDS_SEP
  ]

  def initialize(code, theme: Theme.one_dark_pro)
    @tokens = Prism
      .lex(code)
      .value
      .filter_map { |token, _|
        next if IGNORED_TOKENS.include?(token.type)

        token
      }
    @theme = theme
  end

  def to_html
    row_size = Math.sqrt(@tokens.size).ceil
    rows = @tokens.each_slice(row_size)

    ERB.new(File.read(File.expand_path("../code_picture.erb", __FILE__)))
      .result(binding)
  end

  private attr_reader :theme
end
