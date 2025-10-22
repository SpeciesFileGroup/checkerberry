# frozen_string_literal: true

require 'test_helper'

class DataSourceTest < Test::Unit::TestCase
  def test_data_source
    VCR.use_cassette('data_source') do
      result = Checkerberry.data_source(1)
      assert_not_nil result
      assert_equal result['id'], 1
      assert_equal result['title'], "Catalogue of Life"
    end
  end
end
