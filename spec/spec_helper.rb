$:.unshift '../lib'
require 'snapme'

RSpec.configure do |config|
  config.order = 'random'
end
