# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "flash_cookie_session"
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Trevor Turk"]
  s.date = "2011-05-24"
  s.description = "Useful for Flash-based file uploaders (SWFUpload, Uploadify, Plupload, etc)"
  s.email = ["trevorturk@gmail.com"]
  s.homepage = "http://rubygems.org/gems/flash_cookie_session"
  s.require_paths = ["lib"]
  s.rubyforge_project = "flash_cookie_session"
  s.rubygems_version = "1.8.10"
  s.summary = "Rails 3 cookie sessions can cooperate with Flash"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.0"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0"])
  end
end
