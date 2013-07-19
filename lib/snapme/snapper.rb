require 'curb'

module Snapme
  class Snapper
    attr_reader :auth_token, :command, :host, :interval

    def initialize(host, interval, auth_token = ENV['SNAPME_AUTH_TOKEN'], command = ImagesnapCommand.new)
      @auth_token = auth_token
      @command    = command
      @host       = host
      @interval   = interval
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

    def auth_token_field_name
      'auth_token'
    end

    def file_field_name
      'snapshot'
    end

    def filename
      '/tmp/snapshot.jpg'
    end

    private

    def take_snapshot
      command.call(filename)
    end

    def post_snapshot
      curl.http_post(file_field, auth_token_field)
    end

    def curl
      @curl ||= Curl::Easy.new(endpoint_url).tap do |curl|
        curl.multipart_form_post = true
      end
    end

    def auth_token_field
      Curl::PostField.content(auth_token_field_name, auth_token)
    end

    def file_field
      Curl::PostField.file(file_field_name, filename)
    end
  end
end
