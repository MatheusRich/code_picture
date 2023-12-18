# frozen_string_literal: true

RSpec.describe CodePicture do
  describe "#to_html" do
    it "transforms code into an HTML picture" do
      code = "puts 'Hello World!'"

      picture = CodePicture.new(code).to_html

      expect(picture).to be_valid_html
    end

    it "creates one pixel per token in the code" do
      code = "puts 'Hello World!'"
      options = CodePicture::Options.default

      picture = CodePicture.new(code, options).to_html

      tokens = extract_tokens(code)
      expected_number_of_pixels = tokens.size
      expect(picture).to have_n_pixels(expected_number_of_pixels)
      tokens.each do |token|
        expect(picture).to have_pixel(token, options.theme)
      end
    end

    it "creates √tokens (rounded up) pixels per row" do
      code = "1 + 2 + 3 + 4 + 5 + 6" # 11 tokens. √11 ≈ 3.3

      picture = CodePicture.new(code).to_html

      n_tokens = extract_tokens(code).size
      row_size = Math.sqrt(n_tokens).ceil
      expected_number_of_rows = (n_tokens.to_f / row_size).ceil
      expect(picture).to have_n_rows(expected_number_of_rows)
    end

    it "allows to configure the number of pixels per row" do
      code = "1 + 2 + 3 + 4 + 5 + 6" # 11 tokens. √11 ≈ 3.3
      options = CodePicture::Options.default.with(max_pixels_per_row: 2)

      picture = CodePicture.new(code, options).to_html

      n_tokens = extract_tokens(code).size
      row_size = options.max_pixels_per_row
      expected_number_of_rows = (n_tokens.to_f / row_size).ceil
      expect(picture).to have_n_rows(expected_number_of_rows)
    end

    it "has configurable pixel size" do
      code = "puts :hello"
      options = CodePicture::Options.default.with(pixel_size: 42)

      picture = CodePicture.new(code, options).to_html

      style = Nokogiri::HTML(picture).at("style").text.match(/\.pixel\s*{([^}]*)}/)[1]
      expect(style).to include "width: 42px;"
      expect(style).to include "height: 42px;"
    end

    private

    def have_n_pixels(expected_number_of_pixels)
      HasCss.new(".pixel", count: expected_number_of_pixels)
    end

    def have_pixel(token, theme)
      HasCss.new(%(.pixel[data-content*="#{token.type}"][style*="background-color: #{theme.color_for(token.type)}"]))
    end

    def have_n_rows(expected_number_of_rows)
      HasCss.new(".row", count: expected_number_of_rows)
    end

    def extract_tokens(code)
      Prism
        .lex(code)
        .value
        .filter_map { |token, _|
          next if CodePicture::IGNORED_TOKENS.include?(token.type)

          token
        }
    end
  end
end
