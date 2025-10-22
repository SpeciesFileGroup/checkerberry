# frozen_string_literal: true

require 'test_helper'

class DataSourcesTest < Test::Unit::TestCase
  def test_data_sources
    VCR.use_cassette('data_sources') do
      result = Checkerberry.data_sources
      assert_not_nil result
      assert result.is_a?(Array) || result.is_a?(Hash)
    end
  end
end
