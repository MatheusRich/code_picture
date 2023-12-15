class HasCss
  def initialize(selector, count: nil)
    @selector = selector
    @count = count
  end

  def matches?(string)
    nodes = Nokogiri::HTML(string).css(@selector)

    if nodes.empty?
      @error = "expected to find `#{@selector}` in the HTML"
      return false
    elsif @count && nodes.size != @count
      @error = "expected to find #{@count} `#{@selector}` in the HTML, but found #{nodes.size}"
      return false
    end

    true
  end

  def failure_message = @error
end
