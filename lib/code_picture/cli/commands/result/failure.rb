class CodePicture
  class Cli
    module Commands
      module Result
        Failure = Data.define(:error) do
          def successful? = false

          def failed? = true

          def on_success = self

          def on_failure = yield(error)
        end
      end
    end
  end
end
