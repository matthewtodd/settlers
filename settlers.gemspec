require 'bundler'
$:.unshift File.expand_path('../lib', __FILE__)
require 'settlers'

# Feel free to change whatever you like! This file is yours now.
Gem::Specification.new do |spec|
  spec.name    = 'settlers'
  spec.version = Settlers::VERSION

  spec.summary = "Provides a simple command-line executable for playing Robb Thomas' JSettlers game."

  spec.author = 'Matthew Todd'
  spec.email  = 'matthew.todd@gmail.com'
  spec.homepage = 'http://github.com/matthewtodd/settlers'

  spec.requirements = ['java']
  spec.add_bundler_dependencies

  # The kooky &File.method(:basename) trick keeps us from accidentally
  # shadowing a variable named "file" in the context that evaluates this
  # gemspec. I actually ran into this problem with Bundler!
  spec.files            = Dir['**/*.rdoc', 'bin/*', 'data/**/*', 'ext/**/*.{rb,c}', 'lib/**/*.rb', 'man/**/*', 'test/**/*.rb']
  spec.executables      = Dir['bin/*'].map &File.method(:basename)
  spec.extensions       = Dir['ext/**/extconf.rb']
  spec.extra_rdoc_files = Dir['**/*.rdoc', 'ext/**/*.c']
  spec.test_files       = Dir['test/**/*_test.rb']

  spec.rdoc_options = %W(
    --main README.rdoc
    --title #{spec.full_name}
    --inline-source
    --webcvs http://github.com/matthewtodd/settlers/blob/v#{spec.version}/
  )
end
