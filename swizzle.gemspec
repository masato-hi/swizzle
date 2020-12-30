lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "swizzle/version"

Gem::Specification.new do |spec|
  spec.name          = "swizzle"
  spec.version       = Swizzle::VERSION
  spec.authors       = ["masato"]
  spec.email         = ["masato.hirahata@gmail.com"]

  spec.summary       = "swizzle is a gem for easy to do method swizzling."
  spec.description   = "swizzle is a gem for easy to do method swizzling to class methods, instance methods."
  spec.homepage      = "https://github.com/masato-hi/swizzle"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.7.0"
end
