# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{settlers}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Todd"]
  s.date = %q{2008-10-12}
  s.default_executable = %q{settlers}
  s.email = %q{matthew.todd@gmail.com}
  s.executables = ["settlers"]
  s.files = ["Rakefile", "bin/settlers", "lib/settlers/game.rb", "lib/settlers/jar.rb", "lib/settlers/java_command.rb", "lib/settlers.rb", "resources/jsettlers-1.0.6", "resources/jsettlers-1.0.6/COPYING.txt", "resources/jsettlers-1.0.6/JSettlers.jar", "resources/jsettlers-1.0.6/JSettlersServer.jar", "resources/jsettlers-1.0.6/README.txt", "resources/jsettlers-1.0.6/VERSIONS.txt"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Provides a simple command-line executable for playing Robb Thomas' JSettlers game.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
