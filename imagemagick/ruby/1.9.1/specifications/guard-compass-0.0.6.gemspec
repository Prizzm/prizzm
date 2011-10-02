# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "guard-compass"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Olivier Amblet"]
  s.date = "2010-10-25"
  s.description = "Guard::Compass automatically rebuilds scss|sass files when a modification occurs taking in account your compass configuration."
  s.email = ["olivier@amblet.net"]
  s.homepage = "http://rubygems.org/gems/guard-compass"
  s.require_paths = ["lib"]
  s.rubyforge_project = "guard-compass"
  s.rubygems_version = "1.8.10"
  s.summary = "Guard gem for Compass"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 0.2.1"])
      s.add_runtime_dependency(%q<compass>, [">= 0.10.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0.rc"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0.1.4"])
    else
      s.add_dependency(%q<guard>, [">= 0.2.1"])
      s.add_dependency(%q<compass>, [">= 0.10.5"])
      s.add_dependency(%q<bundler>, ["~> 1.0.2"])
      s.add_dependency(%q<rspec>, ["~> 2.0.0.rc"])
      s.add_dependency(%q<guard-rspec>, [">= 0.1.4"])
    end
  else
    s.add_dependency(%q<guard>, [">= 0.2.1"])
    s.add_dependency(%q<compass>, [">= 0.10.5"])
    s.add_dependency(%q<bundler>, ["~> 1.0.2"])
    s.add_dependency(%q<rspec>, ["~> 2.0.0.rc"])
    s.add_dependency(%q<guard-rspec>, [">= 0.1.4"])
  end
end
