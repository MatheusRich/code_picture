# frozen_string_literal: true

require "spec_helper"

RSpec.describe CodePicture::Cli::Options do
  describe ".from" do
    context "with --pixel-size" do
      it "sets the pixel size option" do
        argv = ["path.rb", "--pixel-size=20"]

        options = CodePicture::Cli::Options.from(argv)

        expect(options.command_options.pixel_size).to eq(20)
        expect(options.command).to eq CodePicture::Cli::Commands::CodePicture
      end
    end

    context "with --theme" do
      it "sets the theme option" do
        argv = ["path.rb", "--theme=monokai"]

        options = CodePicture::Cli::Options.from(argv)

        expect(options.command_options.theme).to eq("monokai")
        expect(options.command).to eq CodePicture::Cli::Commands::CodePicture
      end
    end

    context "with --version" do
      it "sets the version command" do
        argv = ["--version"]

        options = CodePicture::Cli::Options.from(argv)

        expect(options.command).to eq CodePicture::Cli::Commands::Version
      end
    end

    context "with --help" do
      it "sets the help command" do
        argv = ["--help"]

        options = CodePicture::Cli::Options.from(argv)

        expect(options.command).to eq CodePicture::Cli::Commands::Help
        expect(options.command_options.error).to be_nil
      end
    end
  end
end
