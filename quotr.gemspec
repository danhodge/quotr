# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "quotr/version"

Gem::Specification.new do |s|
  s.name        = "quotr"
  s.version     = Quotr::VERSION
  s.authors     = ["Dan Hodge"]
  s.email       = ["danhodge@gmail.com"]
  s.homepage    = "https://github.com/danhodge/quotr"
  s.summary     = %q{Retrieves historical stock and mutual fund quotes}
  s.description = %q{Retrieves historical stock and mutual fund quotes}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # development dependencies
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end
