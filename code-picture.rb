require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "prism"
  gem "nokogiri"
end

require "prism"
require "nokogiri"
require "yaml"
require "net/http"

# TODO:
#   - CLI
#     - Specify File, theme, pixel size, output file
#   - Use ERB instead of Nokogiri?

file = ARGV[0]
abort("Missing file") if file.nil? || !File.exist?(file)

result = Prism.lex_file(file)
abort("Failed to parse file: #{result.errors}") if result.failure?

def rand_color
  red = rand(256).to_s(16).rjust(2, "0")
  green = rand(256).to_s(16).rjust(2, "0")
  blue = rand(256).to_s(16).rjust(2, "0")

  "##{red}#{green}#{blue}"
end

PRISM_CONFIG_URL = "https://raw.githubusercontent.com/ruby/prism/main/config.yml"
ALL_TOKENS = YAML.load(Net::HTTP.get(URI(PRISM_CONFIG_URL)))["tokens"].map { _1["name"].to_sym }.freeze

ONE_DARK_PRO_THEME = {
  AMPERSAND: "#282c34",
  AMPERSAND_AMPERSAND: "#282c34",
  BACKTICK: "#282c34",
  BANG: "#282c34",
  BANG_EQUAL: "#282c34",
  BRACE_LEFT: "#282c34",
  BRACE_RIGHT: "#282c34",
  BRACKET_LEFT: "#282c34",
  BRACKET_LEFT_ARRAY: "#282c34",
  BRACKET_RIGHT: "#282c34",
  COLON: "#282c34",
  COLON_COLON: "#282c34",
  COMMA: "#282c34",
  COMMENT: "#5c6370",
  CONSTANT: "#e5c07b",
  DOT: "#282c34",
  DOT_DOT: "#282c34",
  DOT_DOT_DOT: "#282c34",
  EMBEXPR_BEGIN: "#282c34",
  EMBEXPR_END: "#282c34",
  EQUAL: "#282c34",
  EQUAL_EQUAL: "#282c34",
  EQUAL_GREATER: "#282c34",
  FLOAT: "#e5c07b",
  GREATER: "#282c34",
  GREATER_EQUAL: "#282c34",
  HEREDOC_END: "#98c379",
  HEREDOC_START: "#98c379",
  IDENTIFIER: "#e06c75",
  INSTANCE_VARIABLE: "#e06c75",
  INTEGER: "#e5c07b",
  KEYWORD_ALIAS: "#C678DD",
  KEYWORD_BEGIN: "#C678DD",
  KEYWORD_BREAK: "#C678DD",
  KEYWORD_CASE: "#C678DD",
  KEYWORD_CLASS: "#C678DD",
  KEYWORD_DEF: "#C678DD",
  KEYWORD_DO: "#c678dd",
  KEYWORD_ELSE: "#C678DD",
  KEYWORD_ELSIF: "#C678DD",
  KEYWORD_END: "#c678dd",
  KEYWORD_ENSURE: "#C678DD",
  KEYWORD_FALSE: "#C678DD",
  KEYWORD_IF: "#C678DD",
  KEYWORD_IF_MODIFIER: "#c678dd",
  KEYWORD_MODULE: "#C678DD",
  KEYWORD_NEXT: "#C678DD",
  KEYWORD_NIL: "#e5c07b",
  KEYWORD_RESCUE: "#C678DD",
  KEYWORD_RETURN: "#c678dd",
  KEYWORD_SELF: "#C678DD",
  KEYWORD_SUPER: "#C678DD",
  KEYWORD_THEN: "#C678DD",
  KEYWORD_TRUE: "#C678DD",
  KEYWORD_UNLESS_MODIFIER: "#C678DD",
  KEYWORD_UNTIL: "#C678DD",
  KEYWORD_WHEN: "#C678DD",
  KEYWORD_YIELD: "#C678DD",
  LABEL: "#56b6c2",
  LABEL_END: "#56b6c2",
  LAMBDA_BEGIN: "#282c34",
  LESS: "#282c34",
  LESS_EQUAL: "#282c34",
  LESS_EQUAL_GREATER: "#282c34",
  LESS_LESS: "#282c34",
  METHOD_NAME: "#61afef",
  MINUS: "#282c34",
  MINUS_EQUAL: "#282c34",
  MINUS_GREATER: "#282c34",
  PARENTHESIS_LEFT: "#282c34",
  PARENTHESIS_LEFT_PARENTHESES: "#282c34",
  PARENTHESIS_RIGHT: "#282c34",
  PERCENT: "#282c34",
  PERCENT_EQUAL: "#282c34",
  PERCENT_LOWER_I: "#56b6c2",
  PIPE: "#282c34",
  PIPE_PIPE: "#282c34",
  PLUS: "#282c34",
  PLUS_EQUAL: "#282c34",
  QUESTION_MARK: "#282c34",
  SEMICOLON: "#282c34",
  SLASH: "#282c34",
  STAR: "#282c34",
  STRING_BEGIN: "#98c379",
  STRING_CONTENT: "#98c379",
  STRING_END: "#98c379",
  SYMBOL_BEGIN: "#282c34",
  UAMPERSAND: "#56b6c2",
  USTAR: "#56b6c2",
  USTAR_STAR: "#56b6c2"
}.freeze
RANDOM_COLORS_THEME = {
  BRACE_LEFT: rand_color,
  BRACE_RIGHT: rand_color,
  COMMA: rand_color,
  COMMENT: rand_color,
  CONSTANT: rand_color,
  DOT: rand_color,
  EOF: rand_color,
  EQUAL: rand_color,
  EQUAL_GREATER: rand_color,
  IDENTIFIER: rand_color,
  IGNORED_NEWLINE: rand_color,
  KEYWORD_DO: rand_color,
  KEYWORD_END: rand_color,
  KEYWORD_IF_MODIFIER: rand_color,
  KEYWORD_RETURN: rand_color,
  METHOD_NAME: rand_color,
  NEWLINE: rand_color,
  BACKTICK: rand_color,
  BRACKET_LEFT: rand_color,
  BRACKET_LEFT_ARRAY: rand_color,
  BRACKET_RIGHT: rand_color,
  COLON_COLON: rand_color,
  EMBEXPR_BEGIN: rand_color,
  AMPERSAND: rand_color,
  AMPERSAND_AMPERSAND: rand_color,
  BANG: rand_color,
  COLON: rand_color,
  EMBEXPR_END: rand_color,
  EQUAL_EQUAL: rand_color,
  INSTANCE_VARIABLE: rand_color,
  INTEGER: rand_color,
  KEYWORD_CLASS: rand_color,
  KEYWORD_DEF: rand_color,
  KEYWORD_FALSE: rand_color,
  KEYWORD_IF: rand_color,
  KEYWORD_MODULE: rand_color,
  KEYWORD_NIL: rand_color,
  KEYWORD_RESCUE: rand_color,
  KEYWORD_SELF: rand_color,
  KEYWORD_TRUE: rand_color,
  KEYWORD_UNLESS_MODIFIER: rand_color,
  KEYWORD_YIELD: rand_color,
  LABEL: rand_color,
  LESS: rand_color,
  LESS_LESS: rand_color,
  PARENTHESIS_LEFT: rand_color,
  PARENTHESIS_LEFT_PARENTHESES: rand_color,
  PARENTHESIS_RIGHT: rand_color,
  PERCENT_LOWER_I: rand_color,
  PIPE: rand_color,
  PIPE_PIPE: rand_color,
  QUESTION_MARK: rand_color,
  SEMICOLON: rand_color,
  STAR: rand_color,
  STRING_BEGIN: rand_color,
  STRING_CONTENT: rand_color,
  STRING_END: rand_color,
  SYMBOL_BEGIN: rand_color,
  MINUS_GREATER: rand_color,
  LAMBDA_BEGIN: rand_color,
  KEYWORD_SUPER: rand_color,
  USTAR: rand_color,
  USTAR_STAR: rand_color,
  WORDS_SEP: rand_color,
  FLOAT: rand_color,
  DOT_DOT: rand_color,
  SLASH: rand_color,
  MINUS: rand_color,
  UAMPERSAND: rand_color,
  KEYWORD_BEGIN: rand_color,
  KEYWORD_CASE: rand_color,
  KEYWORD_WHEN: rand_color,
  MINUS_EQUAL: rand_color,
  PERCENT_EQUAL: rand_color,
  PLUS_EQUAL: rand_color,
  PLUS: rand_color,
  KEYWORD_BREAK: rand_color,
  BANG_EQUAL: rand_color,
  DOT_DOT_DOT: rand_color,
  KEYWORD_UNTIL: rand_color,
  GREATER_EQUAL: rand_color,
  KEYWORD_ELSIF: rand_color,
  LESS_EQUAL_GREATER: rand_color,
  LESS_EQUAL: rand_color,
  KEYWORD_ELSE: rand_color,
  GREATER: rand_color,
  PERCENT: rand_color,
  KEYWORD_ENSURE: rand_color
}.freeze

if ENV.has_key?("DEBUG")
  diff = ALL_TOKENS - ONE_DARK_PRO_THEME.keys
  if diff.any?
    puts "Missing tokens in theme:"
    diff.each do |type|
      puts "#{type}: rand_color,"
    end
  end
end

THEME = ONE_DARK_PRO_THEME

Pixel = Data.define(:color, :type, :value)

missing = []
pixels = result.value.filter_map do |(token, _)|
  next if token.type == :WORDS_SEP
  next if token.type == :IGNORED_NEWLINE
  next if token.type == :NEWLINE
  next if token.type == :EOF

  color = THEME[token.type].tap do |color|
    (missing << token.type) if color.nil?
  end

  Pixel.new(color, token.type, token.value)
end

if missing.any?
  missing.uniq.each do |type|
    puts "#{type}: rand_color,"
  end
  exit 1
end

row_size = Math.sqrt(pixels.size).ceil

builder = Nokogiri::HTML4::Builder.new do |doc|
  doc.html do
    doc.style do
      doc.text(
        <<~CSS
          .pixel {
            display: table-cell;
            width: 15px;
            height: 15px;
            position: relative;
          }
        CSS
      )
      doc.text(
        <<~CSS
          .pixel:hover::after {
            display: block;
            content: attr(data-content);
            position: absolute;
            z-index: 100;
            top: 30px;
            background: white;
            color: black;
            padding: 5px;
            min-width: 150px;
            min-height: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
          }
        CSS
      )
      doc.text(".row { display: table-row; }")
    end

    doc.body do
      pixels.each_slice(row_size).each do |row|
        doc.div(class: "row") do
          row.each do |pixel|
            doc.span(
              class: "pixel",
              style: "background-color: #{pixel.color}",
              "data-content": "Type: #{pixel.type}\nValue: #{pixel.value.inspect}"
            )
          end
        end
      end
    end
  end
end

File.write("code-picture.html", builder.to_html)
`open code-picture.html`
