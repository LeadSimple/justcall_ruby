# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "justcall_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "justcall_ruby"
  spec.version = JustCall::VERSION
  spec.authors = ["Jeffrey Dill"]
  spec.email = ["jeffdill2@gmail.com"]
  spec.summary = "A simple Ruby wrapper for the JustCall REST API"
  spec.homepage = "https://github.com/leadsimple/justcall_ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = 'true'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ .git .circleci])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
