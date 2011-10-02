# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spruz"
  s.version = "0.2.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = "2011-08-17"
  s.description = "All the stuff that isn't good/big enough for a real library."
  s.email = "flori@ping.de"
  s.executables = ["enum"]
  s.extra_rdoc_files = ["README.rdoc", "lib/spruz.rb", "lib/spruz/hash_symbolize_keys_recursive.rb", "lib/spruz/string_underscore.rb", "lib/spruz/hash_union.rb", "lib/spruz/write.rb", "lib/spruz/version.rb", "lib/spruz/round.rb", "lib/spruz/go.rb", "lib/spruz/generator.rb", "lib/spruz/string_camelize.rb", "lib/spruz/shuffle.rb", "lib/spruz/deep_dup.rb", "lib/spruz/memoize.rb", "lib/spruz/lines_file.rb", "lib/spruz/subhash.rb", "lib/spruz/bijection.rb", "lib/spruz/limited.rb", "lib/spruz/attempt.rb", "lib/spruz/to_proc.rb", "lib/spruz/module_group.rb", "lib/spruz/null.rb", "lib/spruz/secure_write.rb", "lib/spruz/xt.rb", "lib/spruz/file_binary.rb", "lib/spruz/string_version.rb", "lib/spruz/once.rb", "lib/spruz/xt/named.rb", "lib/spruz/xt/hash_symbolize_keys_recursive.rb", "lib/spruz/xt/string_underscore.rb", "lib/spruz/xt/hash_union.rb", "lib/spruz/xt/write.rb", "lib/spruz/xt/irb.rb", "lib/spruz/xt/round.rb", "lib/spruz/xt/string_camelize.rb", "lib/spruz/xt/shuffle.rb", "lib/spruz/xt/deep_dup.rb", "lib/spruz/xt/symbol_to_proc.rb", "lib/spruz/xt/subhash.rb", "lib/spruz/xt/attempt.rb", "lib/spruz/xt/null.rb", "lib/spruz/xt/secure_write.rb", "lib/spruz/xt/file_binary.rb", "lib/spruz/xt/string_version.rb", "lib/spruz/xt/p.rb", "lib/spruz/xt/partial_application.rb", "lib/spruz/xt/time_dummy.rb", "lib/spruz/xt/string.rb", "lib/spruz/xt/full.rb", "lib/spruz/xt/range_plus.rb", "lib/spruz/xt/count_by.rb", "lib/spruz/xt/blank.rb", "lib/spruz/xt/uniq_by.rb", "lib/spruz/p.rb", "lib/spruz/minimize.rb", "lib/spruz/partial_application.rb", "lib/spruz/time_dummy.rb", "lib/spruz/range_plus.rb", "lib/spruz/count_by.rb", "lib/spruz/uniq_by.rb"]
  s.files = ["bin/enum", "README.rdoc", "lib/spruz.rb", "lib/spruz/hash_symbolize_keys_recursive.rb", "lib/spruz/string_underscore.rb", "lib/spruz/hash_union.rb", "lib/spruz/write.rb", "lib/spruz/version.rb", "lib/spruz/round.rb", "lib/spruz/go.rb", "lib/spruz/generator.rb", "lib/spruz/string_camelize.rb", "lib/spruz/shuffle.rb", "lib/spruz/deep_dup.rb", "lib/spruz/memoize.rb", "lib/spruz/lines_file.rb", "lib/spruz/subhash.rb", "lib/spruz/bijection.rb", "lib/spruz/limited.rb", "lib/spruz/attempt.rb", "lib/spruz/to_proc.rb", "lib/spruz/module_group.rb", "lib/spruz/null.rb", "lib/spruz/secure_write.rb", "lib/spruz/xt.rb", "lib/spruz/file_binary.rb", "lib/spruz/string_version.rb", "lib/spruz/once.rb", "lib/spruz/xt/named.rb", "lib/spruz/xt/hash_symbolize_keys_recursive.rb", "lib/spruz/xt/string_underscore.rb", "lib/spruz/xt/hash_union.rb", "lib/spruz/xt/write.rb", "lib/spruz/xt/irb.rb", "lib/spruz/xt/round.rb", "lib/spruz/xt/string_camelize.rb", "lib/spruz/xt/shuffle.rb", "lib/spruz/xt/deep_dup.rb", "lib/spruz/xt/symbol_to_proc.rb", "lib/spruz/xt/subhash.rb", "lib/spruz/xt/attempt.rb", "lib/spruz/xt/null.rb", "lib/spruz/xt/secure_write.rb", "lib/spruz/xt/file_binary.rb", "lib/spruz/xt/string_version.rb", "lib/spruz/xt/p.rb", "lib/spruz/xt/partial_application.rb", "lib/spruz/xt/time_dummy.rb", "lib/spruz/xt/string.rb", "lib/spruz/xt/full.rb", "lib/spruz/xt/range_plus.rb", "lib/spruz/xt/count_by.rb", "lib/spruz/xt/blank.rb", "lib/spruz/xt/uniq_by.rb", "lib/spruz/p.rb", "lib/spruz/minimize.rb", "lib/spruz/partial_application.rb", "lib/spruz/time_dummy.rb", "lib/spruz/range_plus.rb", "lib/spruz/count_by.rb", "lib/spruz/uniq_by.rb"]
  s.homepage = "http://flori.github.com/spruz"
  s.rdoc_options = ["--title", "Spruz - Useful stuff.", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Useful stuff."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 0.0.11"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.3"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 0.0.11"])
      s.add_dependency(%q<test-unit>, ["~> 2.3"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 0.0.11"])
    s.add_dependency(%q<test-unit>, ["~> 2.3"])
  end
end
