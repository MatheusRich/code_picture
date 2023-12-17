class CodePicture
  class Cli
    Options = Data.define(:command, :command_options) do
      def self.empty = new(command: nil, command_options: Commands::TakePicture::Options.empty)

      def self.from(argv)
        options = Cli::Options.empty

        opt_parser = OptionParser.new do |parser|
          parser.banner = "Usage: code-picture path-to-file.rb [options]"

          parser.on("-v", "--version", "Displays app version") do
            options = options.with(command: Commands::Version, command_options: nil)
          end

          parser.on("-p", "--pixel-size=SIZE", Integer, "Define the pixel size of the generated image") do |size|
            command_options = options.command_options.with(pixel_size: size)
            options = options.with(command_options:)
          end

          parser.on("-t", "--theme=THEME", String, "Define the theme of the generated image") do |theme|
            command_options = options.command_options.with(theme: theme)
            options = options.with(command_options:)
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

        if (file_path = argv.first)
          options.with(
            command: Commands::TakePicture,
            command_options: options.command_options.with(file_path:)
          )
        elsif options.command.nil?
          options.with(
            command: Commands::Help,
            command_options: Commands::Help::Options.new(
              error: "Missing file path",
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
