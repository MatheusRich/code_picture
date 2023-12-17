# frozen_string_literal: true

require "code_picture"
require "nokogiri"

Dir[File.join(__dir__, "support/**/*.rb")].sort.each { require _1 }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixture_file_path(file_name)
  File.join(__dir__, "fixtures", file_name)
end

def fixture_file(file_name)
  File.read(fixture_file_path(file_name))
end
