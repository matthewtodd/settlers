require 'rubygems'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name             = 'settlers'
  s.version          = '0.1.0'
  s.summary          = "Provides a simple command-line executable for playing Robb Thomas' JSettlers game."
  s.files            = FileList['[A-Z]*', 'bin/*', 'resources/**/*']
  s.executables      = ['settlers']
  s.author           = 'Matthew Todd'
  s.email            = 'matthew.todd@gmail.com'
end

Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end

desc 'Remove all generated artifacts.'
task :clobber => :clobber_package

desc 'Generate a gemspec file'
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end
