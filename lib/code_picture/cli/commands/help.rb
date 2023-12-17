class CodePicture
  class Cli
    module Commands
      module Help
        Options = Data.define(:error, :help_text) do
          def initialize(help_text:, error: nil) = super
        end

        def self.call(options)
          puts options.help_text

          if options.error
            Result::Failure.new(error: options.error)
          else
            Result::Success.new(value: nil)
          end
        end
      end
    end
  end
end
