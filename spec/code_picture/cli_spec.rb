# frozen_string_literal: true

require "spec_helper"

RSpec.describe CodePicture::Cli do
  describe "#call" do
    context "with file name" do
      it "generates a code picture and writes it to a file" do
        argv = [fixture_file_path("sample.rb")]

        result = nil
        expect {
          result = CodePicture::Cli.new.call(argv)
        }.to output(/Generated code picture and wrote it to `code-picture.html`/).to_stdout

        expect(result).to be_successful
        expect(result.value).to eq fixture_file("sample-code-picture-snapshot.html")
        expect(File.read("code-picture.html")).to eq fixture_file("sample-code-picture-snapshot.html")

        File.delete("code-picture.html") if File.exist?("code-picture.html")
      end
    end

    context "when the file does not exist" do
      it "returns an error" do
        argv = ["unknown.rb"]

        result = CodePicture::Cli.new.call(argv)

        expect(result).to be_failed
        expect(result.error).to eq("Couldn't find file `unknown.rb`")
      end
    end

    context "without file name" do
      it "prints the help" do
        argv = []

        result = nil
        expect {
          result = CodePicture::Cli.new.call(argv)
        }.to output(/Usage: code-picture/).to_stdout

        expect(result).to be_failed
        expect(result.error).to eq("Missing input file path")
      end
    end

    context "with --output" do
      it "writes the code picture to the given file path" do
        argv = [fixture_file_path("sample.rb"), "--output", "my-code-picture.html"]

        result = nil
        expect {
          result = CodePicture::Cli.new.call(argv)
        }.to output(/Generated code picture and wrote it to `my-code-picture.html`/).to_stdout

        expect(result).to be_successful
        expect(File.read("my-code-picture.html")).to eq fixture_file("sample-code-picture-snapshot.html")

        File.delete("my-code-picture.html") if File.exist?("my-code-picture.html")
      end
    end

    context "with --version" do
      it "prints the version" do
        cli = CodePicture::Cli.new

        expect { cli.call(["-v"]) }.to output("code-picture v#{CodePicture::VERSION}\n").to_stdout
      end
    end

    context "with no arguments"

    context "with invalid option" do
      it "prints the help" do
        argv = ["--unknown-option"]

        expect { CodePicture::Cli.new.call(argv) }.to output(/Usage: code-picture/).to_stdout
      end
    end
  end
end
