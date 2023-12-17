require "optparse"

class CodePicture
  class Cli
    def call(argv)
      Options
        .from(argv)
        .then { _1.command.call(_1.command_options) }
    end
  end
end
