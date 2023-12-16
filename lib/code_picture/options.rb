class CodePicture
  Options = Data.define(:pixel_size, :theme) do
    def self.default = new(pixel_size: 15, theme: Theme.one_dark_pro)
  end
end
