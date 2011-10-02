# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jwt"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Lindsay"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDPDCCAiSgAwIBAgIBADANBgkqhkiG9w0BAQUFADBEMRUwEwYDVQQDDAxqZWZm\nLmxpbmRzYXkxFjAUBgoJkiaJk/IsZAEZFgZ0d2lsaW8xEzARBgoJkiaJk/IsZAEZ\nFgNjb20wHhcNMTAwNTA0MjE0NzE3WhcNMTEwNTA0MjE0NzE3WjBEMRUwEwYDVQQD\nDAxqZWZmLmxpbmRzYXkxFjAUBgoJkiaJk/IsZAEZFgZ0d2lsaW8xEzARBgoJkiaJ\nk/IsZAEZFgNjb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDb1P6c\n/CN4l2pYBO0d5y7YHW3XJbj5d+5c1E9m2PcvUJ4Vjr7ISQM1SYpwixnWMBXBpzc1\nEn9YB+PYBEOOaIRh2G23aKdu7PnYQhze91qOBcHnf6LOckq25NbWQO8eaiXD3w5W\nHRXOcmzigyTYRIhXBa93eMSihWAXThcfGFKNbtKerVhytT/UVHZU3pr9gCvt9vD0\naBmwMwvDlpO72eXPr5ow3Z+VzCc51iBNC07uvR/wFQ6/lS8ULBpHI9wcdo67wdv5\nSaSZSGZCmG1pXov0Ahji7yqFMQ9oot5RDPZavZN3Fh3n6e2hdcSMlLgGkEGYaBVx\ngdQFudko7rc5cWTdAgMBAAGjOTA3MAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0G\nA1UdDgQWBBRXFNQ8j0GGeMiiPWhAlHB356JPGDANBgkqhkiG9w0BAQUFAAOCAQEA\nVzMJe10HfJtglbDah9h9lxv8uzK2uV7bXRcIbMCGEdx8cByM+cfKOnoWVDQBVPWA\nVznqXdPsrVC70PAMMTk66ro2ciyudilVEuxEl7rhaz0tj9FzNyJUHBKCD4KpGwkC\nK435qpJsHMi9k0KxY17grmsE2Hq60lFLK8ZrqgDblEAKTeaGAykMxp9KJOwAKnY2\n4lUY/SVtRuTk0YXsIPNFLYUhYt7arkJtkwWV41GWhj7PbcM5uk5sGoh0aueMzY7f\nTvklqXtUw3g3PcoJ8CZw68WaB2/MuJXUehRCZThhkBwi8bDKZzh4rtI/WEb1EgDs\nWZqts+sMhUpDxxL+p6p6bQ==\n-----END CERTIFICATE-----\n"]
  s.date = "2011-06-30"
  s.description = "JSON Web Token implementation in Ruby"
  s.email = "jeff.lindsay@twilio.com"
  s.extra_rdoc_files = ["lib/jwt.rb"]
  s.files = ["lib/jwt.rb"]
  s.homepage = "http://github.com/progrium/ruby-jwt"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Jwt", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "jwt"
  s.rubygems_version = "1.8.10"
  s.summary = "JSON Web Token implementation in Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.2.4"])
    else
      s.add_dependency(%q<json>, [">= 1.2.4"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.2.4"])
  end
end
