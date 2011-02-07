$:.unshift File.expand_path('../lib', __FILE__)
require 'settlers'

# Feel free to change whatever you like! This file is yours now.
Gem::Specification.new do |spec|
  spec.name    = 'settlers'
  spec.version = Settlers::VERSION

  spec.summary = "Robb Thomas' JSettlers game, wrapped up in a Ruby script with Bonjour support."

  spec.author = 'Matthew Todd'
  spec.email  = 'matthew.todd@gmail.com'
  spec.homepage = 'http://github.com/matthewtodd/settlers'

  spec.requirements = ['java']
  spec.add_runtime_dependency     'dnssd',             '~> 1.3.1'
  spec.add_runtime_dependency     'highline',          '~> 1.5.2'
  spec.add_runtime_dependency     'optparse-defaults', '~> 0.1.0'
  spec.add_development_dependency 'shoe',              '~> 0.7.1'

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
