class CodePicture
  Theme = Data.define(:colors) do
    self::Error = Class.new(StandardError)

    def self.find(name)
      case name.to_s.tr("-", "_")
      when "one_dark_pro"
        one_dark_pro
      when "random"
        random
      else
        from_file(name)
      end
    end

    def self.from_file(file_name)
      require "yaml"
      colors = YAML.load_file(file_name, symbolize_names: true)

      unless colors.is_a?(Hash)
        raise self::Error, "Theme file `#{file_name}` must be a mapping of token types to colors"
      end

      new(colors:)
    rescue Psych::SyntaxError
      raise self::Error, "Invalid syntax in theme file `#{file_name}`"
    rescue Errno::ENOENT
      raise self::Error, "Couldn't find theme file `#{file_name}`"
    end

    def self.default = one_dark_pro

    def self.random
      theme = {}
      new(->(token_type) {
        theme[token_type] ||= random_color
      })
    end

    def self.one_dark_pro
      from_file(File.expand_path("../themes/one_dark_pro.yml", __FILE__))
    end

    def self.random_color
      "hsl(#{rand(0..360)},#{rand(70..110)}%,#{rand(40..90)}%)"
    end
    private_class_method :random_color

    def color_for(token_type)
      colors[token_type] || raise(self.class::Error, "No theme color defined for token type `#{token_type}`")
    end
  end
end
