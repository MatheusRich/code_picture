# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"
require "code_picture"

task default: %i[spec standard]

task :check_missing_token_types do
  require "yaml"
  require "net/http"

  prism_config_url = "https://raw.githubusercontent.com/ruby/prism/a590c031130ab024488177fa7ccf18c970dce20d/config.yml"
  all_tokens = YAML.load(Net::HTTP.get(URI(prism_config_url)))["tokens"].map { _1["name"].to_sym }
  current_tokens = CodePicture::Theme.one_dark_pro.colors.keys
  missing_tokens = (all_tokens - current_tokens) - CodePicture::IGNORED_TOKENS

  if missing_tokens.any?
    abort missing_tokens.join("\n")
  end
end
