# frozen_string_literal: true

require "test_helper"

class CheckerberryTest < Test::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Checkerberry::VERSION
  end
end
