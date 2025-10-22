# frozen_string_literal: true

require 'test_helper'

class PingTest < Test::Unit::TestCase
  def test_ping
    VCR.use_cassette('ping') do
      result = Checkerberry.ping
      assert_not_nil result
      assert_equal "pong", result
    end
  end
end
