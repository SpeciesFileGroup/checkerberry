# frozen_string_literal: true

require 'test_helper'

class SearchTest < Test::Unit::TestCase
  def test_search_single_name
    VCR.use_cassette('search_single_name') do
      result = Checkerberry.search(name_string: "Homo sapiens", genus: 'Homo', species: 'sapiens')
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_equal result['names'][0]['name'], 'Homo sapiens'
    end
  end

  def test_parent_taxon_plantae
    VCR.use_cassette('search_parent_taxon_plantae') do
      result = Checkerberry.search(parent_taxon: "Plantae", genus: 'Homo', species: 'sapiens')
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_equal result['metadata']['namesNumber'], 0
    end
  end

  def test_parent_taxon_animalia
    VCR.use_cassette('search_parent_taxon_animalia') do
      result = Checkerberry.search(parent_taxon: "Animalia", genus: 'Homo', species: 'sapiens')
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_operator result['metadata']['namesNumber'], :>, 0
    end
  end

  def test_query
    VCR.use_cassette('search_query') do
      result = Checkerberry.search(query: "n:B. bubo ds:1,2 au:Linn. y:1700-")
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_operator result['metadata']['namesNumber'], :>, 0
    end
  end

  def test_year_start
    VCR.use_cassette('search_year_start') do
      error = assert_raise(ArgumentError) do
        Checkerberry.search(year_start: 1700, genus: 'Homo', species: 'sapiens')
      end
      assert_equal 'year_end is required when year_start is provided', error.message
    end
  end

  def test_year_end
    VCR.use_cassette('search_year_end') do
      error = assert_raise(ArgumentError) do
        Checkerberry.search(year_end: 1800, genus: 'Homo', species: 'sapiens')
      end
      assert_equal 'year_start is required when year_end is provided', error.message
    end
  end

  def test_year_range_year
    VCR.use_cassette('search_year_end') do
      error = assert_raise(ArgumentError) do
        Checkerberry.search(year_start: 1700, year_end: 1800, year: 1888, genus: 'Homo', species: 'sapiens')
      end
      assert_equal 'year cannot be provided when year_start and year_end are provided', error.message
    end
  end

  def test_year_range
    VCR.use_cassette('search_year_range') do
      year_start = 1990
      year_end = 2000
      result = Checkerberry.search(year_start: year_start, year_end: year_end, species: 'alba')
      year_match = result.dig('names', 0, 'bestResult', 'matchedName').match(/(\d{4})/)
      year = year_match[1].to_i
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_operator year, :>=, year_start
      assert_operator year, :<=, year_end
    end
  end

  def test_year
    VCR.use_cassette('search_year') do
      result = Checkerberry.search(year: 1995, species: 'alba')
      assert_not_nil result
      assert result.is_a?(Hash)
      year_match = result.dig('names', 0, 'bestResult', 'matchedName').match(/(\d{4})/)
      year = year_match[1].to_i
      assert_operator year, :==, 1995
    end
  end

  def test_data_source
    VCR.use_cassette('search_data_source') do
      result = Checkerberry.search(data_sources: 1, species: 'alba')
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_operator result['metadata']['namesNumber'], :>, 0
      result['names'].each do |name|
        assert_equal 1, name['bestResult']['dataSourceId']
      end
    end
  end

  def test_data_sources_array
    VCR.use_cassette('search_data_sources_array') do
      result = Checkerberry.search(data_sources: [1, 3], species: 'alba')
      assert_not_nil result
      assert result.is_a?(Hash)
      assert_operator result['metadata']['namesNumber'], :>, 0
      result['names'].each do |name|
        assert_includes [1, 3], name['bestResult']['dataSourceId']
      end
    end
  end
end