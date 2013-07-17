module Snapme
  class ImagesnapCommand
    def call(filename)
      `#{command} #{filename}`
    end

    private

    def command
      'bin/imagesnap'
    end
  end
end
