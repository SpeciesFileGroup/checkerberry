# frozen_string_literal: true

require 'test_helper'

class DataSourcesTest < Test::Unit::TestCase
  def test_data_sources
    VCR.use_cassette('data_sources') do
      result = Checkerberry.data_sources
      assert_not_nil result
      assert_operator result.length, :>, 0
      assert_equal result[0]['id'], 1
      assert_equal result[0]['title'], "Catalogue of Life"
    end
  end
end
