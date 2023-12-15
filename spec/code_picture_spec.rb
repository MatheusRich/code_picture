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

      picture = CodePicture.new(code, theme: CodePicture::Theme.one_dark_pro).to_html

      tokens = extract_tokens(code)
      expected_number_of_pixels = tokens.size
      expect(picture).to have_n_pixels(expected_number_of_pixels)
      tokens.each do |token|
        expect(picture).to have_pixel(token, theme: CodePicture::Theme.one_dark_pro)
      end
    end

    it "creates √tokens (rounded up) rows of pixels" do
      code = "puts :hello"

      picture = CodePicture.new(code).to_html

      expected_number_of_rows = Math.sqrt(extract_tokens(code).size).ceil
      expect(picture).to have_n_rows(expected_number_of_rows)
    end

    private

    def have_n_pixels(expected_number_of_pixels)
      HasCss.new(".pixel", count: expected_number_of_pixels)
    end

    def have_pixel(token, theme:)
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
