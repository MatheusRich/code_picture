class CodePicture
  Theme = Data.define(:colors) do
    def self.find_or_default(name)
      case name.to_s.tr("-", "_")
      when "one_dark_pro"
        one_dark_pro
      when "random"
        random
      else
        warn "Couldn't find theme `#{other.theme}`. Using default theme."
        Theme.default
      end
    end

    def self.default = one_dark_pro

    def self.random
      theme = {}
      new(->(token_type) {
        theme[token_type] ||= random_hex_color
      })
    end

    def self.one_dark_pro
      new({
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
        KEYWORD___FILE__: "#e5c07b",
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
        PERCENT_LOWER_W: "#56b6c2",
        PIPE: "#282c34",
        PIPE_PIPE: "#282c34",
        PLUS: "#282c34",
        PLUS_EQUAL: "#282c34",
        QUESTION_MARK: "#282c34",
        REGEXP_BEGIN: "#e06c75",
        REGEXP_END: "#e06c75",
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
      })
    end

    def self.random_hex_color
      "#%06x" % (rand * 0xffffff)
    end
    private_class_method :random_hex_color

    def color_for(token_type)
      colors[token_type]
    end
  end
end
