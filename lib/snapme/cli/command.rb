module Snapme
  module CLI
    class Command
      def self.start(args)
        options = Options.parse(args)
        Process.daemon(true) if options.daemon
        Snapper.new(options.host, options.interval).run
      end
    end
  end
end
