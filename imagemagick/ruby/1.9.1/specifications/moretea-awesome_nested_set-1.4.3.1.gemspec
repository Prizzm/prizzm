# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "moretea-awesome_nested_set"
  s.version = "1.4.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brandon Keepers", "Daniel Morrison"]
  s.date = "2010-08-30"
  s.description = "An awesome nested set implementation for Active Record"
  s.email = "info@collectiveidea.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/collectiveidea/awesome_nested_set"
  s.rdoc_options = ["--main", "README.rdoc", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "An awesome nested set implementation for Active Record"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])
    else
      s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
  end
end
