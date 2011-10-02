# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "formtastic"
  s.version = "1.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin French"]
  s.date = "2011-05-31"
  s.description = "A Rails form builder plugin/gem with semantically rich and accessible markup"
  s.email = "justin@indent.com.au"
  s.extra_rdoc_files = ["README.textile"]
  s.files = ["README.textile"]
  s.homepage = "http://github.com/justinfrench/formtastic/tree/master"
  s.post_install_message = "\n  ========================================================================\n  Thanks for installing Formtastic!\n  ------------------------------------------------------------------------\n  You can now (optionally) run the generator to copy some stylesheets and\n  a config initializer into your application:\n    rails generate formtastic:install # Rails 3\n    ./script/generate formtastic      # Rails 2\n\n  To generate some semantic form markup for your existing models, just run:\n    rails generate formtastic:form MODEL_NAME # Rails 3\n    ./script/generate form MODEL_NAME         # Rails 2\n\n  Find out more and get involved:\n    http://github.com/justinfrench/formtastic\n    http://groups.google.com.au/group/formtastic\n  ========================================================================\n  "
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A Rails form builder plugin/gem with semantically rich and accessible markup"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.7"])
      s.add_runtime_dependency(%q<actionpack>, [">= 2.3.7"])
      s.add_runtime_dependency(%q<i18n>, ["~> 0.4"])
      s.add_development_dependency(%q<rails>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.0.0"])
      s.add_development_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
      s.add_development_dependency(%q<hpricot>, ["~> 0.8.3"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.7"])
      s.add_dependency(%q<actionpack>, [">= 2.3.7"])
      s.add_dependency(%q<i18n>, ["~> 0.4"])
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.0.0"])
      s.add_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
      s.add_dependency(%q<hpricot>, ["~> 0.8.3"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.7"])
    s.add_dependency(%q<actionpack>, [">= 2.3.7"])
    s.add_dependency(%q<i18n>, ["~> 0.4"])
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.0.0"])
    s.add_dependency(%q<rspec_tag_matchers>, [">= 1.0.0"])
    s.add_dependency(%q<hpricot>, ["~> 0.8.3"])
  end
end
