require_relative "faraday"
require "faraday/follow_redirects"
require_relative "utils"
require "checkerberry/error"
require "multi_json"

module Checkerberry
  class Request
    include Utils
    attr_accessor :endpoint, :verbose

    def initialize(**args)
      @endpoint = args[:endpoint]
      @verbose = args[:verbose]
      @method = args[:method] || :get
      @names = args[:names]
      @data_sources = args[:data_sources]
      @vernacular_languages = args[:vernacular_languages]
      @with_all_matches = args[:with_all_matches]
      @with_capitalization = args[:with_capitalization]
      @with_species_group = args[:with_species_group]
      @with_uninomial_fuzzy_match = args[:with_uninomial_fuzzy_match]
      @with_stats = args[:with_stats]
      @min_taxon_threshold = args[:min_taxon_threshold]
      @query = args[:query]
      @parent_taxon = args[:parent_taxon]
      @name_string = args[:name_string]
      @genus = args[:genus]
      @species = args[:species]
      @species_any = args[:species_any]
      @infraspecies = args[:infraspecies]
      @author = args[:author]
      @year = args[:year]
      @year_start = args[:year_start]
      @year_end = args[:year_end]
      @with_all_results = args[:with_all_results]
    end

    def perform
      args = {
        nameStrings: @names,
        dataSources: @data_sources,
        vernaculars: @vernacular_languages,
        withAllMatches: @with_all_matches,
        withCapitalization: @with_capitalization,
        withSpeciesGroup: @with_species_group,
        withUninomialFuzzyMatch: @with_uninomial_fuzzy_match,
        withStats: @with_stats,
        mainTaxonThreshold: @min_taxon_threshold,
        query: @query,
        parentTaxon: @parent_taxon,
        nameString: @name_string,
        genus: @genus,
        species: @species,
        speciesAny: @species_any,
        speciesInfra: @infraspecies,
        author: @author,
        year: @year,
        withAllResults: @with_all_results
      }
      opts = args.delete_if { |_k, v| v.nil? }

      if @year_start && @year_end
        opts[:yearRange] = { yearStart: @year_start, yearEnd: @year_end }
      end

      conn = Faraday.new(url: Checkerberry.base_url) do |f|
        f.request :json
        f.response :logger if @verbose
        f.use Faraday::CheckerberryErrors::Middleware
        f.adapter Faraday.default_adapter
      end

      conn.headers['Accept'] = 'application/json'
      conn.headers['Content-Type'] = 'application/json' if @method == :post
      conn.headers[:user_agent] = make_user_agent
      conn.headers["X-USER-AGENT"] = make_user_agent

      res = if @method == :post
              conn.post(endpoint, opts.to_json)
            else
              conn.get(endpoint, opts)
            end

      begin
        MultiJson.load(res.body)
      rescue MultiJson::ParseError
        res.body
      end
    end
  end
end
