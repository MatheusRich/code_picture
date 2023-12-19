class CodePicture
  class Cli
    module Commands
      module TakePicture
        Options = Data.define(:input_file_path, :output_file_path, *CodePicture::Options.members) do
          def self.default = new(
            input_file_path: nil,
            output_file_path: "code-picture.html",
            **CodePicture::Options.default.to_h
          )
        end

        extend self

        def call(options)
          code_picture = take_picture(options)
          save_picture(code_picture, options.output_file_path)

          Result::Success.new(value: code_picture)
        rescue Errno::ENOENT
          Result::Failure.new(error: "Couldn't find file `#{options.input_file_path}`")
        rescue CodePicture::Theme::Error => error
          Result::Failure.new(error: error.message)
        end

        private

        def take_picture(options)
          source_code = File.read(options.input_file_path)

          ::CodePicture.new(source_code, CodePicture::Options.from(options)).to_html
        end

        def save_picture(code_picture, output_file_path)
          File.write(output_file_path, code_picture)
          puts "Generated code picture and wrote it to `#{output_file_path}`"
        end
      end
    end
  end
end
