# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "default_value_for"
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hongli Lai"]
  s.date = "2011-08-10"
  s.description = "The default_value_for plugin allows one to define default values for ActiveRecord models in a declarative manner"
  s.email = "info@phusion.nl"
  s.homepage = "http://github.com/FooBarWidget/default_value_for"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Provides a way to specify default values for ActiveRecord models"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
