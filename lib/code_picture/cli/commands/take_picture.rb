class CodePicture
  class Cli
    module Commands
      module TakePicture
        Options = Data.define(:input_file_path, *CodePicture::Options.members) do
          def self.empty = new(input_file_path: nil, **CodePicture::Options.default.to_h)
        end

        extend self

        def call(options)
          code_picture = take_picture(options)
          save_picture(code_picture)

          Result::Success.new(value: code_picture)
        rescue Errno::ENOENT
          Result::Failure.new(error: "Couldn't find file `#{options.input_file_path}`")
        end

        private

        def take_picture(options)
          source_code = File.read(options.input_file_path)

          ::CodePicture.new(source_code, CodePicture::Options.from(options)).to_html
        end

        def save_picture(code_picture)
          File.write("code-picture.html", code_picture)
          puts "Generated code picture and wrote it to `code-picture.html`"
        end
      end
    end
  end
end
