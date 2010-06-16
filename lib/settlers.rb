require 'pathname'
require 'rbconfig'
require 'rbconfig/datadir'

module Settlers
  VERSION = '0.2.1'

  autoload :Application,      'settlers/application'
  autoload :Bonjour,          'settlers/bonjour'
  autoload :Client,           'settlers/client'
  autoload :Java,             'settlers/java'
  autoload :Server,           'settlers/server'
  autoload :ServerCollection, 'settlers/server_collection'
  autoload :UserInteraction,  'settlers/user_interaction'

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
