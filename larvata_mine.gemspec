require_relative 'lib/larvata_mine/version'

Gem::Specification.new do |spec|
  spec.name          = "larvata_mine"
  spec.version       = LarvataMine::VERSION
  spec.authors       = ["Frank Lam"]
  spec.email         = ["ryzingsun11@yahoo.com"]

  spec.summary       = "This gem is an API client wrapper for Redmine"
  spec.description   = "This gem is an API client wrapper for Redmine"
  spec.homepage      = "https://github.com/FTLam11/larvata_mine"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/FTLam11/larvata_mine"
  spec.metadata["changelog_uri"] = "https://github.com/FTLam11/larvata_mine"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'http'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
  spec.add_development_dependency 'awesome_print', '~> 1.8'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'dotenv'
end
