require 'optparse'

module Snapme
  module CLI
    class Options
      DEFAULT_HOST     = 'http://snapme.herokuapp.com'
      DEFAULT_INTERVAL = 30 #seconds

      attr_reader :daemon, :host, :interval, :show_version

      def initialize(daemon: true, host: DEFAULT_HOST, interval: DEFAULT_INTERVAL, show_version: false)
        @daemon   = !!(daemon)
        @host     = host
        @interval = interval.to_i
        @show_version = show_version
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

          opts.on('-v', '--version', 'Print snapme version') do
            options[:show_version] = true
          end
        end.parse!(args)

        new(options)
      end
    end
  end
end
