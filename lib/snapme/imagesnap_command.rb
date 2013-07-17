module Snapme
  class ImagesnapCommand
    def call(filename)
      `#{command_name} #{filename}`
    end

    private

    def command_name
      'bin/imagesnap'
    end
  end
end
