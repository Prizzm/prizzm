# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mash"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Bleigh"]
  s.date = "2009-11-11"
  s.description = "Mash is an extended Hash that gives simple pseudo-object functionality that can be built from hashes and easily extended."
  s.email = "michael@intridea.com"
  s.extra_rdoc_files = ["README.txt"]
  s.files = ["README.txt"]
  s.homepage = "http://github.com/mbleigh/mash"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "An extended Hash that gives simple pseudo-object functionality that can be built from hashes and easily extended."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
