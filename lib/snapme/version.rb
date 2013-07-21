module Snapme
  module Version
    MAJOR = 0
    MINOR = 2
    PATCH = 2
    PRE   = nil

    def self.to_s
      [MAJOR, MINOR, PATCH, PRE].compact.join('.')
    end
  end
end
