# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "forgery"
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Sutton", "Brandon Arbini"]
  s.date = "2011-09-04"
  s.description = "Easy and customizable generation of forged data. Can be used as a gem or a rails plugin. Includes rails generators for creating your own forgeries."
  s.email = ["nate@zencoder.com", "brandon@zencoder.com"]
  s.homepage = "http://github.com/sevenwire/forgery"
  s.require_paths = ["lib"]
  s.rubyforge_project = "forgery"
  s.rubygems_version = "1.8.10"
  s.summary = "Easy and customizable generation of forged data."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.4"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.4"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
