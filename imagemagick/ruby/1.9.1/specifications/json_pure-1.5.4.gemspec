# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "json_pure"
  s.version = "1.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = "2011-08-31"
  s.description = "This is a JSON implementation in pure Ruby."
  s.email = "flori@ping.de"
  s.executables = ["edit_json.rb", "prettify_json.rb"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["bin/edit_json.rb", "bin/prettify_json.rb", "README.rdoc"]
  s.homepage = "http://flori.github.com/json"
  s.rdoc_options = ["--title", "JSON implemention for ruby", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "json"
  s.rubygems_version = "1.8.10"
  s.summary = "JSON Implementation for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<permutation>, [">= 0"])
      s.add_development_dependency(%q<bullshit>, [">= 0"])
      s.add_development_dependency(%q<sdoc>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_runtime_dependency(%q<spruz>, ["~> 0.2.8"])
    else
      s.add_dependency(%q<permutation>, [">= 0"])
      s.add_dependency(%q<bullshit>, [">= 0"])
      s.add_dependency(%q<sdoc>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<spruz>, ["~> 0.2.8"])
    end
  else
    s.add_dependency(%q<permutation>, [">= 0"])
    s.add_dependency(%q<bullshit>, [">= 0"])
    s.add_dependency(%q<sdoc>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<spruz>, ["~> 0.2.8"])
  end
end
