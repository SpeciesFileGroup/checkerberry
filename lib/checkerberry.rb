# frozen_string_literal: true

require "erb"
require_relative "checkerberry/error"
require_relative "checkerberry/version"
require_relative "checkerberry/request"
require "checkerberry/helpers/configuration"

module Checkerberry
  extend Configuration

  define_setting :base_url, "https://verifier.globalnames.org/api/v1"
  define_setting :mailto, ENV["GNVERIFIER_API_EMAIL"]

  # Verify scientific names
  #
  # @param names [String, Array] A single name or array of names to verify
  # @param sources [Array, Integer] Data source IDs to use for verification
  # @param all_matches [Boolean] Return all matches for each name
  # @param preferred_sources [Array, Integer] Preferred data source IDs
  # @param capitalize [Boolean] Capitalize the first letter of names
  # @param main_taxon_only [Boolean] Return only the main taxon
  # @param species_group [Boolean] Match to species group
  # @param with_stats [Boolean] Include statistics in response
  # @param with_all_matches [Boolean] Include all matches in response
  # @param with_vernaculars [Boolean] Include vernacular names
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A hash with verification results
  def self.verify(names, sources: nil, all_matches: nil, preferred_sources: nil,
                 capitalize: nil, main_taxon_only: nil, species_group: nil,
                 with_stats: nil, with_all_matches: nil, with_vernaculars: nil,
                 verbose: false)
    endpoint = "verifications"
    names_array = names.is_a?(Array) ? names : [names]
    Request.new(endpoint: endpoint, method: :post, names: names_array, sources: sources,
                all_matches: all_matches, preferred_sources: preferred_sources,
                capitalize: capitalize, main_taxon_only: main_taxon_only,
                species_group: species_group, with_stats: with_stats,
                with_all_matches: with_all_matches, with_vernaculars: with_vernaculars,
                verbose: verbose).perform
  end

  # Get list of data sources
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Array] An array of data source information
  def self.data_sources(verbose: false)
    endpoint = "data_sources"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Get version information
  #
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A hash with version information
  def self.version(verbose: false)
    endpoint = "version"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end

  # Get a single data source by ID
  #
  # @param source_id [Integer] The data source ID
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A hash with data source information
  def self.data_source(source_id, verbose: false)
    endpoint = "data_sources/#{source_id}"
    Request.new(endpoint: endpoint, verbose: verbose).perform
  end
end
