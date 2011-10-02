# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "workflow"
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Vladimir Dobriakov"]
  s.date = "2011-08-19"
  s.description = "    Workflow is a finite-state-machine-inspired API for modeling and interacting\n    with what we tend to refer to as 'workflow'.\n\n    * nice DSL to describe your states, events and transitions\n    * robust integration with ActiveRecord and non relational data stores\n    * various hooks for single transitions, entering state etc.\n    * convenient access to the workflow specification: list states, possible events\n      for particular state\n"
  s.email = "vladimir@geekq.net"
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown"]
  s.homepage = "http://www.geekq.net/workflow/"
  s.require_paths = ["lib"]
  s.rubyforge_project = "workflow"
  s.rubygems_version = "1.8.10"
  s.summary = "A replacement for acts_as_state_machine."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
