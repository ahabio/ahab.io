# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "guard"
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Thibaud Guillaume-Gentil"]
  s.date = "2013-10-18"
  s.description = "Guard is a command line tool to easily handle events on file system modifications."
  s.email = ["thibaud@thibaud.me"]
  s.executables = ["guard"]
  s.files = ["bin/guard"]
  s.homepage = "http://guardgem.org"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "1.8.23"
  s.summary = "Guard keeps an eye on your file modifications"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, [">= 0.18.1"])
      s.add_runtime_dependency(%q<listen>, ["~> 2.1"])
      s.add_runtime_dependency(%q<pry>, [">= 0.9.12"])
      s.add_runtime_dependency(%q<lumberjack>, ["~> 1.0"])
      s.add_runtime_dependency(%q<formatador>, [">= 0.2.4"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
    else
      s.add_dependency(%q<thor>, [">= 0.18.1"])
      s.add_dependency(%q<listen>, ["~> 2.1"])
      s.add_dependency(%q<pry>, [">= 0.9.12"])
      s.add_dependency(%q<lumberjack>, ["~> 1.0"])
      s.add_dependency(%q<formatador>, [">= 0.2.4"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
    end
  else
    s.add_dependency(%q<thor>, [">= 0.18.1"])
    s.add_dependency(%q<listen>, ["~> 2.1"])
    s.add_dependency(%q<pry>, [">= 0.9.12"])
    s.add_dependency(%q<lumberjack>, ["~> 1.0"])
    s.add_dependency(%q<formatador>, [">= 0.2.4"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
  end
end
