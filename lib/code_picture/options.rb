class CodePicture
  Options = Data.define(:pixel_size, :theme) do
    def self.default = new(pixel_size: 15, theme: Theme.one_dark_pro)

    def self.from(other) = new(**other.to_h.slice(*members))
  end
end
