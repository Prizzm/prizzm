# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "acts_as_commentable_with_threading"
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Evan Light", "Jack Dempsey", "Xelipe", "xxx"]
  s.date = "2011-12-07"
  s.description = "Polymorphic threaded comments Rails gem for Rails 3+"
  s.email = "evan@tripledogdare.net"
  s.homepage = "http://github.com/elight/acts_as_commentable_with_threading"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Polymorphic comments Rails gem - Rails 3+ only"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["~> 3.0"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_runtime_dependency(%q<moretea-awesome_nested_set>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 1.3"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 3.0"])
      s.add_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<moretea-awesome_nested_set>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 1.3"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 3.0"])
    s.add_dependency(%q<activerecord>, ["~> 3.0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<moretea-awesome_nested_set>, [">= 0"])
  end
end
