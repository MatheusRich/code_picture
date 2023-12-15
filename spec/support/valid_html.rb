module ValidHtmlHelper
  class ValidHtmlChecker
    def matches?(string)
      !!Nokogiri::HTML(string) do |config|
        config.strict.noblanks
      end
    rescue Nokogiri::SyntaxError
      false
    end

    def failure_message
      "is not valid HTML"
    end
  end

  def be_valid_html
    ValidHtmlChecker.new
  end
end

RSpec.configure do |config|
  config.include ValidHtmlHelper
end
