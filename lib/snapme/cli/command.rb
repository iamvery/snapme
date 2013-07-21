module Snapme
  module CLI
    class Command
      def self.start(args)
        options    = Options.parse(args)
        auth_token = ENV['SNAPME_AUTH_TOKEN']

        if options.kill
          `killall snapme`
          return
        end

        if options.show_version
          puts Snapme::Version
          return
        end

        if auth_token
          Process.daemon(true) if options.daemon
          Snapper.new(options.host, options.interval, auth_token).run
        else
          puts <<-MSG
  Please set SNAPME_AUTH_TOKEN in your environment. You can get your
  auth token from http://snapme.herokuapp.com
          MSG
        end
      end
    end
  end
end
