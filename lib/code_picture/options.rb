class CodePicture
  Options = Data.define(:pixel_size, :theme, :max_pixels_per_row) do
    def self.default = new(pixel_size: 15, theme: Theme.one_dark_pro, max_pixels_per_row: nil)

    def self.from(other)
      theme = if other.theme.is_a?(String)
        Theme.find(other.theme)
      else
        other.theme
      end

      options = other.to_h.slice(*members).merge(theme:)

      new(**options)
    end
  end
end
