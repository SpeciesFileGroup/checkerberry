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
  # @param data_sources [Array, Integer] The data source IDs to use for verification
  # @param vernacular_languages [String, Array] A single language ISO 639-3 or an array of ISO 639-3 languages for vernacular names
  # @param with_all_matches [Boolean] Show all matches for each name
  # @param with_capitalization [Boolean] Capitalize the first character
  # @param with_species_group [Boolean] Match to species group
  # @param with_uninomial_fuzzy_match [Boolean] Enable uninomial fuzzy matching
  # @param with_stats [Boolean] Include statistics in response
  # @param min_taxon_threshold [Float] The minimum taxon threshold for main taxon assignment
  # @param verbose [Boolean] Print headers to STDOUT
  #
  # @return [Hash] A hash with verification results
  def self.verify(names, data_sources: nil, vernacular_languages: nil,
                  with_all_matches: nil, with_capitalization: nil,
                  with_species_group: nil, with_uninomial_fuzzy_match: nil,
                  with_stats: nil, min_taxon_threshold: nil, verbose: false)
    endpoint = "verifications"
    names_array = names.is_a?(Array) ? names : [names]
    data_sources_array = data_sources.is_a?(Array) ? data_sources : (data_sources.nil? ? nil : [data_sources])
    Request.new(endpoint: endpoint, method: :post, names: names_array,
                data_sources: data_sources_array, vernacular_languages: vernacular_languages,
                with_all_matches: with_all_matches, with_capitalization: with_capitalization,
                with_species_group: with_species_group, with_uninomial_fuzzy_match: with_uninomial_fuzzy_match,
                with_stats: with_stats, min_taxon_threshold: min_taxon_threshold,
                verbose: verbose).perform
  end

  # Search for scientific names
  # 
  # @param query [String] The search query
  # @param data_sources [Array, Integer] The data source IDs to use for verification
  # @param parent_taxon [String] The parent taxon name
  # @param name_string [String] The exact name string to search for
  # @param genus [String] The genus name
  # @param species [String] The species name
  # @param species_any [String] Any part of the species name
  # @param infraspecies [String] The infraspecies name
  # @param author [String] The author name
  # @param year [Integer] The year of publication
  # @param year_start [Integer] The start year for a range search
  # @param year_end [Integer] The end year for a range search
  # @param with_all_results [Boolean] Show all matches for each name
  def self.search(query: nil, data_sources: nil, parent_taxon: nil,
                  name_string: nil, genus: nil, species: nil,
                  species_any: nil, infraspecies: nil, author: nil,
                  year: nil, year_start: nil, year_end: nil,
                  with_all_results: nil, verbose: false)
    endpoint = "search"

    # require year_start and year_end together
    if year_start && !year_end
      raise ArgumentError, "year_end is required when year_start is provided"
    end
    if year_end && !year_start
      raise ArgumentError, "year_start is required when year_end is provided"
    end

    # require no year if year_start and year_end are provided
    if (year_start || year_end) && year
      raise ArgumentError, "year cannot be provided when year_start and year_end are provided"
    end

    data_sources_array = data_sources.is_a?(Array) ? data_sources : (data_sources.nil? ? nil : [data_sources])
    Request.new(endpoint: endpoint, method: :post,
                query: query, data_sources: data_sources_array, parent_taxon: parent_taxon,
                name_string: name_string, genus: genus, species: species,
                species_any: species_any, infraspecies: infraspecies,
                author: author, year: year, year_start: year_start,
                year_end: year_end, with_all_results: with_all_results,
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

  # Ping the API (check if the service is alive)
  #
  # @param verbose [Boolean] Print headers to STDOUT
  def self.ping(verbose: false)
    endpoint = "ping"
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
end
