# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "textmath/version"

Gem::Specification.new do |s|
  s.name        = "textmath"
  s.version     = TextMath::VERSION
  s.authors     = ["Andrew Horsman"]
  s.email       = ["minirobotics@gmail.com"]
  s.homepage    = "http://github.com/basicxman/textmath"
  s.summary     = "Converts flat text math to LaTeX."
  s.description = "Meant for homework and output to OpenOffice.  Converts ASCII text math to a LaTeX formatted document."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
