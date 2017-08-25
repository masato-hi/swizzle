$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "swizzle"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each do |file|
  require file
end

require "minitest/autorun"
