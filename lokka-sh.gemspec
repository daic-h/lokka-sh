$:.unshift File.expand_path(File.dirname(__FILE__) + "/lib")
require "lokka-sh/version"

Gem::Specification.new do |s|
  s.name        = "lokka-sh"
  s.version     = LokkaSh::VERSION
  s.authors     = ["Dach_h"]
  s.email       = ["bunny.hop.md@gmail.com"]
  s.homepage    = ""
  s.summary     = "excute sub commands of lokka quickly."
  s.description = s.summary
  s.rubyforge_project = "lokka-sh"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rake', '0.9.2'
  s.add_development_dependency 'rspec',   '2.8.0'
  s.add_development_dependency 'bundler', '1.1.0'
end





