# frozen_string_literal: true

require_relative "lib/invaders/version"

Gem::Specification.new do |spec|
  spec.name = "invaders"
  spec.version = Invaders::VERSION
  spec.authors = ["Rafał Lisowski"]
  spec.email = ["lisowski.r@gmail.com"]

  spec.summary = "Take a radar sample as an argument and reveal possible locations of those pesky invaders."
  spec.description = <<~DESC
    Space invaders are upon us!
    You were shortlisted as one of the great minds to help us track them down.

    Your Ruby application must take a radar sample as an argument and reveal possible locations of those pesky invaders.
    Good luck!
  DESC
  spec.homepage = "https://github.com/rlisowski/invaders"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rlisowski/invaders"
  spec.metadata["changelog_uri"] = "https://github.com/rlisowski/invaders"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
end
