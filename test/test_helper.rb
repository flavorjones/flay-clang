$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'flay_clang'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

FLAY_CLANG_FIXTURES = Pathname.new File.join(File.dirname(__FILE__), "fixtures")
