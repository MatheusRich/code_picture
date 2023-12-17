class CodePicture
  class Cli
    module Commands
      module Result
        Success = Data.define(:value) do
          def successful? = true

          def failed? = false

          def on_success = yield(value)

          def on_failure = self
        end
      end
    end
  end
end
