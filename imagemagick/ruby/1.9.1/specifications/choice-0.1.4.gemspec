# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "choice"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Wanstrath"]
  s.autorequire = "choice"
  s.date = "2009-10-03"
  s.description = "Choice is a simple little gem for easily defining and parsing command line options with a friendly DSL."
  s.email = "chris@ozmm.org"
  s.homepage = "http://choice.rubyforge.org/"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Choice is a command line option parser."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
