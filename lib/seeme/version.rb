module Seeme
  module Version
    MAJOR = 0
    MINOR = 0
    PATCH = 0
    PRE   = nil

    def self.to_s
      [MAJOR, MINOR, PATCH, PRE].compact.join('.')
    end
  end
end
