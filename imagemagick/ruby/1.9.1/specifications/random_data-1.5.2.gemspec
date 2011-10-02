# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "random_data"
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Subelsky", "Tom Harris"]
  s.date = "2010-11-15"
  s.description = "Random data generator"
  s.email = "thomas.e.harris@gmail.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/tomharris/random_data"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A Ruby gem that provides a Random class with a series of methods for generating random test data including names, mailing addresses, dates, phone numbers, e-mail addresses, and text."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
