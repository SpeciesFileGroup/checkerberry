# frozen_string_literal: true

require_relative "lib/checkerberry/version"

Gem::Specification.new do |s|
  s.name          = "checkerberry"
  s.version       = Checkerberry::VERSION
  s.authors       = ["Matt Yoder, Geoff Ower"]
  s.email         = ["diapriid@gmail.com"]

  s.summary       = "GNverifier API Client"
  s.description   = "checkerberry is a low-level wrapper around the GNverifier API for scientific name verification."
  s.homepage      = "https://github.com/SpeciesFileGroup/checkerberry"
  s.license       = "MIT"
  s.required_ruby_version = ">= 2.5.0"

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/SpeciesFileGroup/checkerberry"
  s.metadata["changelog_uri"] = "https://github.com/SpeciesFileGroup/checkerberry/releases/tag/v#{s.version}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|s|features)/}) }
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 2.1", ">= 2.1.4"
  s.add_development_dependency "rake", "~> 13.0", ">= 13.0.1"
  s.add_development_dependency "test-unit", "~> 3.3", ">= 3.3.6"
  s.add_development_dependency "vcr", "~> 6.0"
  s.add_development_dependency "webmock", "~> 3.18"
  s.add_development_dependency "rexml", "~> 3.3", ">= 3.3.6"

  s.add_runtime_dependency "faraday", "~> 2.2"
  s.add_runtime_dependency "faraday-follow_redirects", "~> 0.1"
  s.add_runtime_dependency "multi_json", "~> 1.15"
end
