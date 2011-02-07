require 'pathname'
# We need rubygems for Gem.datadir, since RbConfig.datadir has been deprecated.
# Feels like a step backwards?
require 'rubygems'
require 'settlers/version'

module Settlers
  autoload :Address,     'settlers/address'
  autoload :Application, 'settlers/application'
  autoload :Bonjour,     'settlers/bonjour'
  autoload :Client,      'settlers/client'
  autoload :Collector,   'settlers/collector'
  autoload :Java,        'settlers/java'
  autoload :Observer,    'settlers/observer'
  autoload :Server,      'settlers/server'
  autoload :UI,          'settlers/ui'

  def self.datadir
    Pathname.new(Gem.datadir('settlers'))
  end
end
