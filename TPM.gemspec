# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "TPM"
  s.version     = TPM::VERSION
  s.authors     = ["Aurelien Vallee"]
  s.email       = ["vallee.aurelien@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Tiny Package Manager}
  s.description = %q{Tiny Package Manager}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
