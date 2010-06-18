require 'optparse'

class OptionParser
  # This extension allows for default options in OptionParser, processing
  # them before any given options and appending them nicely to the help
  # message. (It also does the conventional thing and errors with usage when
  # there's trouble parsing options.)
  #
  # Note that it's important to use #order rather than #permute, to ensure
  # that the given options have a chance to override the defaults. (These are
  # <tt>POSIX</tt>-ly correct semantics.)
  #
  # To use:
  #   parser = OptionsParser.new do |opts|
  #              opts.extend(OptionParser::Defaults)
  #              opts.defaults = %w(--foo --no-bar --baz=42)
  #              # ... and so on ...
  #            end
  #
  #   parser.order(ARGV)
  module Defaults
    attr_reader :defaults

    def defaults=(defaults)
      @defaults = defaults.extend(Arguments)
    end

    def order(*args, &block)
      super(*defaults.followed_by(*args), &block)
    rescue ParseError
      abort($!)
    end

    def help
      defaults.help(super, summary_indent)
    end

    private

    module Arguments #:nodoc:
      def followed_by(*args)
        dup.concat(args.flatten)
      end

      def help(before, indent)
        "#{before}\nDefaults:\n#{indent}#{join ' '}"
      end
    end
  end
end
