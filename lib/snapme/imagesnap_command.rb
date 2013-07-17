module Snapme
  class ImagesnapCommand
    def call(filename)
      `#{command_name} #{filename}`
    end

    private

    def command_name
      'imagesnap'
    end
  end
end
