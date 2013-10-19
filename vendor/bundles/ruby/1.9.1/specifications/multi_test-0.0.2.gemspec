# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "multi_test"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Wynne", "Steve Tooke"]
  s.date = "2013-07-19"
  s.description = "Wafter-thin gem to help control rogue test/unit/autorun requires"
  s.email = "cukes@googlegroups.com"
  s.homepage = "http://cukes.info"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "multi-test-0.0.2"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
