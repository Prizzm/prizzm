# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "workflow_on_mongoid"
  s.version = "0.8.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.7") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mani Tadayon"]
  s.date = "2011-07-26"
  s.description = "Lets you use the Workflow gem with your Mongoid documents to add state machine functionality."
  s.email = ["bowsersenior@gmail.com"]
  s.extra_rdoc_files = ["MIT_LICENSE", "README.rdoc"]
  s.files = ["MIT_LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/bowsersenior/workflow_on_mongoid"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Add Mongoid support to the Workflow gem."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<workflow>, ["~> 0.8"])
      s.add_runtime_dependency(%q<mongoid>, [">= 2.0.0.rc.1"])
      s.add_runtime_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["= 0.9.2"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug>, [">= 0"])
    else
      s.add_dependency(%q<workflow>, ["~> 0.8"])
      s.add_dependency(%q<mongoid>, [">= 2.0.0.rc.1"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<rake>, ["= 0.9.2"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<ruby-debug>, [">= 0"])
    end
  else
    s.add_dependency(%q<workflow>, ["~> 0.8"])
    s.add_dependency(%q<mongoid>, [">= 2.0.0.rc.1"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<rake>, ["= 0.9.2"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<ruby-debug>, [">= 0"])
  end
end
