# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "guard-jammit"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pelle Braendgaard"]
  s.date = "2011-08-24"
  s.description = "This is a guard plugin to watch javascript and stylesheets to afterwards run jammit."
  s.email = ["pelle@stakeventures.com"]
  s.homepage = "http://github.com/guard/guard-jammit"
  s.require_paths = ["lib"]
  s.rubyforge_project = "guard-jammit"
  s.rubygems_version = "1.8.10"
  s.summary = "Guard plugin for Jammit"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 0"])
      s.add_runtime_dependency(%q<jammit>, [">= 0"])
    else
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<jammit>, [">= 0"])
    end
  else
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<jammit>, [">= 0"])
  end
end
