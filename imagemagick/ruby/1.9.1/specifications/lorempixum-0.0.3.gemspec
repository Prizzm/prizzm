# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "lorempixum"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Spangenberg"]
  s.date = "2011-04-17"
  s.description = "This gem generates image urls for placeholder images."
  s.email = ["daniel.spangenberg@parcydo.com"]
  s.homepage = "http://neonlex.github.com"
  s.require_paths = ["lib"]
  s.rubyforge_project = "lorempixum"
  s.rubygems_version = "1.8.10"
  s.summary = "With these gem you can easily have nice placeholder images in your app."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
