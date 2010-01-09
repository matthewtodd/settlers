begin
  require 'shoe'
rescue LoadError
  abort 'Please `gem install shoe` to get started.'
end

Shoe.tie('settlers', '0.2.0', "Provides a simple command-line executable for playing Robb Thomas' JSettlers game.") do |spec|
  spec.add_dependency 'dnssd'
  spec.add_dependency 'highline'
end
