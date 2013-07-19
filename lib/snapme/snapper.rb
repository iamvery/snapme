require 'curb'

module Snapme
  class Snapper
    attr_reader :command, :host, :interval

    def initialize(host, interval, command = ImagesnapCommand.new)
      @command  = command
      @host     = host
      @interval = interval
    end

    def run(looping = true)
      loop do
        take_snapshot
        post_snapshot
        break unless looping
        sleep(interval)
      end
    end

    def endpoint_url
      "#{host}/snapshot"
    end

    def filename
      '/tmp/snapshot.jpg'
    end

    private

    def take_snapshot
      command.call(filename)
    end

    def post_snapshot
      curl.http_post(file, auth_token)
    end

    def curl
      @curl ||= Curl::Easy.new(endpoint_url).tap do |curl|
        curl.multipart_form_post = true
      end
    end

    def auth_token
      Curl::PostField.content('auth_token', ENV['AUTH_TOKEN'])
    end

    def file
      Curl::PostField.file('snapshot', filename)
    end
  end
end
