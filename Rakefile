require 'rubygems'

spec = Gem::Specification.new do |s|
  s.name             = 'settlers'
  s.version          = '0.1.2'
  s.summary          = "Provides a simple command-line executable for playing Robb Thomas' JSettlers game."
  s.files            = FileList['[A-Z]*', 'bin/*', 'lib/**/*.rb', 'resources/**/*']
  s.executables      = ['settlers']
  s.author           = 'Matthew Todd'
  s.email            = 'matthew.todd@gmail.com'
end

desc 'Generate a gemspec file'
task :default do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
