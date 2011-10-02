# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "randexp"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Burkert"]
  s.autorequire = "randexp"
  s.date = "2010-02-16"
  s.description = "Library for generating random strings."
  s.email = "ben@benburkert.com"
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["README", "LICENSE", "TODO"]
  s.homepage = "http://github.com/benburkert/randexp"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Library for generating random strings."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ParseTree>, [">= 0"])
    else
      s.add_dependency(%q<ParseTree>, [">= 0"])
    end
  else
    s.add_dependency(%q<ParseTree>, [">= 0"])
  end
end
