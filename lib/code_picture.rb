# frozen_string_literal: true

require "prism"
require "erb"
require "zeitwerk"

Zeitwerk::Loader.for_gem.setup

class CodePicture
  IGNORED_TOKENS = %i[
    EOF
    IGNORED_NEWLINE
    NEWLINE
    WORDS_SEP
  ]
  HTML_TEMPLATE = File.read(File.expand_path("../code_picture/template.erb", __FILE__))

  def initialize(code, options = Options.default)
    @tokens = Prism
      .lex(code)
      .value
      .filter_map { |token, _| token if !IGNORED_TOKENS.include?(token.type) }
    @options = options
  end

  def to_html
    row_size = Math.sqrt(@tokens.size).ceil
    rows = @tokens.each_slice(row_size)

    ERB.new(HTML_TEMPLATE).result(binding)
  end

  private

  def theme = @options.theme

  def pixel_size = @options.pixel_size
end
