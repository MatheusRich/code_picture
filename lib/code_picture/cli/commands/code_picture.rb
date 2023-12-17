class CodePicture
  class Cli
    module Commands
      module CodePicture
        # consider not flattening the options
        Options = Data.define(:file_path, *::CodePicture::Options.members) do
          def self.empty = new(file_path: nil, **::CodePicture::Options.default.to_h)
        end

        def self.call(options)
          code_picture_options = ::CodePicture::Options.new(
            **options.to_h.slice(*::CodePicture::Options.members)
          )
          source_code = File.read(options.file_path)

          Result::Success.new(
            value: ::CodePicture.new(source_code, code_picture_options).to_html
          )
        rescue Errno::ENOENT
          Result::Failure.new(error: "Couldn't find file `#{options.file_path}`")
        end
      end
    end
  end
end
