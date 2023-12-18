class CodePicture
  class Cli
    Options = Data.define(:command, :command_options) do
      def self.empty = new(command: nil, command_options: Commands::TakePicture::Options.default)

      def self.from(argv)
        options = Cli::Options.empty

        opt_parser = OptionParser.new do |parser|
          parser.banner = "Usage: code-picture path-to-file.rb [options]"

          parser.on("-p", "--pixel-size=SIZE", Integer, "Define the pixel size of the generated image") do |size|
            command_options = options.command_options.with(pixel_size: size)
            options = options.with(command_options:)
          end

          parser.on("-r", "--max-pixels-per-row=SIZE", Integer, "Define the maximum number of pixels per row") do |size|
            command_options = options.command_options.with(max_pixels_per_row: size)
            options = options.with(command_options:)
          end

          parser.on("-t", "--theme=THEME", String, "Define the theme of the generated image [options: one-dark-pro (default), random]") do |theme|
            command_options = options.command_options.with(theme: theme)
            options = options.with(command_options:)
          end

          parser.on("-o", "--output=FILE", String, "Write the generated image to the given file path") do |file|
            command_options = options.command_options.with(output_file_path: file)
            options = options.with(command_options:)
          end

          parser.on("-v", "--version", "Displays app version") do
            options = options.with(command: Commands::Version, command_options: nil)
          end
          parser.on("-h", "--help", "Prints this help") do
            options = Cli::Options.new(
              command: Commands::Help,
              command_options: Commands::Help::Options.new(help_text: parser.to_s)
            )
          end
        end

        begin
          opt_parser.parse!(argv)
        rescue OptionParser::InvalidOption
          options = Cli::Options.new(
            command: Commands::Help,
            command_options: Commands::Help::Options.new(help_text: opt_parser.to_s)
          )
        end

        if (input_file_path = argv.first)
          options.with(
            command: Commands::TakePicture,
            command_options: options.command_options.with(input_file_path:)
          )
        elsif options.command.nil?
          options.with(
            command: Commands::Help,
            command_options: Commands::Help::Options.new(
              error: "Missing input file path",
              help_text: opt_parser.to_s
            )
          )
        else
          options
        end
      end
    end
  end
end
