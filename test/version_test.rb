# frozen_string_literal: true

require 'test_helper'

class VersionTest < Test::Unit::TestCase
  def test_version
    VCR.use_cassette('version') do
      result = Checkerberry.version
      assert_not_nil result
      assert result.is_a?(Hash) || result.is_a?(String)
    end
  end
end
