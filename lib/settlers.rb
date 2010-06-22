require 'pathname'
require 'rbconfig'
require 'rbconfig/datadir'

module Settlers
  VERSION = '0.3.1'

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
    @@datadir ||= begin
      datadir = RbConfig.datadir('settlers')
      if !File.exist?(datadir)
        warn "#{datadir} does not exist. Trying again with data directory relative to __FILE__."
        datadir = File.expand_path('../../data/settlers', __FILE__)
      end
      Pathname.new(datadir)
    end
  end
end
