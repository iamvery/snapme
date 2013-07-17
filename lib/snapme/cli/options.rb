require 'optparse'

module Snapme
  module CLI
    class Options
      DEFAULT_HOST     = 'http://snapme.herokuapp.com'
      DEFAULT_INTERVAL = 30 #seconds

      attr_reader :daemon, :host, :interval

      def initialize(daemon: true, host: DEFAULT_HOST, interval: DEFAULT_INTERVAL)
        @daemon   = !!(daemon)
        @host     = host
        @interval = interval.to_i
      end

      def self.parse(args)
        options = {}

        OptionParser.new do |opts|
          opts.banner = 'Usage: snapme [options]'

          opts.on('-h', '--help', 'Show this message') do
            puts opts
            exit
          end

          opts.on('-H', '--host [URL]', 'Snapme service web address') do |url|
            options[:host] = url
          end

          opts.on('-d', '--[no-]daemon', 'Daemonize process') do |daemon|
            options[:daemon] = daemon
          end

          opts.on('-i', '--interval [SECONDS]', 'Snapshot interval') do |seconds|
            options[:interval] = seconds
          end
        end.parse!(args)

        new(options)
      end
    end
  end
end
