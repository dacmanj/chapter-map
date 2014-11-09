ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"

class ActiveSupport::TestCase
  fixtures :all
end

#if __FILE__ == $0
#  $LOAD_PATH.unshift('lib', 'spec')
#  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
#end