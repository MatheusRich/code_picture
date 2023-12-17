class CodePicture
  class Cli
    module Commands
      Version = ->(_) do
        puts "code-picture v#{::CodePicture::VERSION}"
      end
    end
  end
end
