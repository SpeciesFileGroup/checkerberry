# frozen_string_literal: true

require 'test_helper'

class VerifyTest < Test::Unit::TestCase
  def test_verify_single_name
    VCR.use_cassette('verify_single_name') do
      result = Checkerberry.verify('Homo sapiens')
      assert_not_nil result
      assert result.is_a?(Hash)
    end
  end

  def test_verify_multiple_names
    VCR.use_cassette('verify_multiple_names') do
      result = Checkerberry.verify(['Homo sapiens', 'Mus musculus'])
      assert_not_nil result
      assert result.is_a?(Hash)
    end
  end
end
