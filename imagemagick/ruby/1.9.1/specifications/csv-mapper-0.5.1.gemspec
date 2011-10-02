# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "csv-mapper"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luke Pillow"]
  s.date = "2010-05-18"
  s.description = "CSV Mapper makes it easy to import data from CSV files directly to a collection of any type of Ruby object. The simplest way to create mappings is declare the names of the attributes in the order corresponding to the CSV file column order."
  s.email = "lpillow@gmail.com"
  s.extra_rdoc_files = ["History.txt", "LICENSE", "README.rdoc"]
  s.files = ["History.txt", "LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/pillowfactory/csv-mapper"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "CsvMapper is a small library intended to simplify the common steps involved with importing CSV files to a usable form in Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<fastercsv>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<fastercsv>, [">= 0"])
  end
end
