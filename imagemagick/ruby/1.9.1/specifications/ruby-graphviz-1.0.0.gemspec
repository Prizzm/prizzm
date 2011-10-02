# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ruby-graphviz"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gregoire Lejeune"]
  s.date = "2011-05-01"
  s.description = "Ruby/Graphviz provides an interface to layout and generate images of directed graphs in a variety of formats (PostScript, PNG, etc.) using GraphViz."
  s.email = "gregoire.lejeune@free.fr"
  s.executables = ["ruby2gv", "gem2gv", "dot2ruby", "git2gv", "xml2gv"]
  s.extra_rdoc_files = ["README.rdoc", "COPYING", "AUTHORS"]
  s.files = ["bin/ruby2gv", "bin/gem2gv", "bin/dot2ruby", "bin/git2gv", "bin/xml2gv", "README.rdoc", "COPYING", "AUTHORS"]
  s.homepage = "http://github.com/glejeune/Ruby-Graphviz"
  s.post_install_message = "\nSince version 0.9.2, Ruby/GraphViz can use Open3.popen3 (or not)\nOn Windows, you can install 'win32-open3'\n\nYou need to install GraphViz (http://graphviz.org/) to use this Gem.\n\nFor more information about Ruby-Graphviz :\n* Doc : http://rdoc.info/projects/glejeune/Ruby-Graphviz\n* Sources : http://github.com/glejeune/Ruby-Graphviz\n* NEW - Mailing List : http://groups.google.com/group/ruby-graphviz\n\n/!\\ Version 0.9.12 introduce a new solution to connect edges to node ports\nFor more information, see http://github.com/glejeune/Ruby-Graphviz/issues/#issue/13\nSo if you use node ports, maybe you need to change your code.\n\n/!\\ GraphViz::Node#name has been removed!\n\n/!\\ :output and :file options have been removed!\n\n/!\\ The html attribut has been removed!\nYou can use the label attribut, as dot do it : :label => '<<html/>>'\n\n/!\\ Version 0.9.17 introduce GraphML (http://graphml.graphdrawing.org/) support and\ngraph theory !\n"
  s.rdoc_options = ["--title", "Ruby/GraphViz", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "ruby-asp"
  s.rubygems_version = "1.8.10"
  s.summary = "Interface to the GraphViz graphing tool"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
