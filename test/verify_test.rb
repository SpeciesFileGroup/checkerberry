# frozen_string_literal: true

require 'test_helper'

class VerifyTest < Test::Unit::TestCase
  def test_verify_single_name
    VCR.use_cassette('verify_single_name') do
      result = Checkerberry.verify('Homo sapiens')
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_equal result['metadata']['namesNumber'], 1
      assert_equal result['names'][0]['name'], 'Homo sapiens'
    end
  end

  def test_verify_multiple_names
    VCR.use_cassette('verify_multiple_names') do
      result = Checkerberry.verify(['Homo sapiens', 'Mus musculus'])
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_equal result['metadata']['namesNumber'], 2
      assert_equal result['names'][0]['name'], 'Homo sapiens'
      assert_equal result['names'][1]['name'], 'Mus musculus'
    end
  end

  def test_verify_data_source
    VCR.use_cassette('verify_data_source') do
      result = Checkerberry.verify('Homo sapiens', data_sources: 1)
      assert_not_nil result
      assert result.is_a?(Hash)
      result['names'].each do |name|
        assert_equal 1, name['bestResult']['dataSourceId']
      end
    end
  end

  def test_verify_data_source_array
    VCR.use_cassette('verify_data_source_array') do
      result = Checkerberry.verify('Homo sapiens', data_sources: [1, 2, 3])
      assert_not_nil result
      assert result.is_a?(Hash) 
      result['names'].each do |name|
        assert_includes [1, 2, 3], name['bestResult']['dataSourceId']
      end
    end
  end

  def test_uninomial_fuzzy_match
    VCR.use_cassette('verify_uninomial_fuzzy_match') do
      result = Checkerberry.verify('Cyphoderrris', with_uninomial_fuzzy_match: true)
      assert_not_nil result
      assert result.is_a?(Hash)
      result['names'].each do |name|
        assert_equal 'Cyphoderris', name['bestResult']['matchedCanonicalSimple']
      end
    end
  end

  def test_uninomial_exact_match
    VCR.use_cassette('verify_uninomial_exact_match') do
      result = Checkerberry.verify('Cyphoderrris', with_uninomial_fuzzy_match: false)
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_equal 'NoMatch', result['names'][0]['matchType']
      assert_equal 1, result['names'].length
    end
  end
end
