require_relative "faraday"
require "faraday/follow_redirects"
require_relative "utils"
require "checkerberry/error"
require "multi_json"

module Checkerberry
  class Request
    include Utils
    attr_accessor :endpoint, :verbose, :options

    def initialize(**args)
      @endpoint = args[:endpoint]
      @verbose = args[:verbose]
      @method = args[:method] || :get
      @names = args[:names]
      @sources = args[:sources]
      @all_matches = args[:all_matches]
      @preferred_sources = args[:preferred_sources]
      @capitalize = args[:capitalize]
      @main_taxon_only = args[:main_taxon_only]
      @species_group = args[:species_group]
      @with_stats = args[:with_stats]
      @with_all_matches = args[:with_all_matches]
      @with_vernaculars = args[:with_vernaculars]
      @options = args[:options]
    end

    def perform
      args = {
        names: @names,
        sources: @sources,
        allMatches: @all_matches,
        preferredSources: @preferred_sources,
        capitalize: @capitalize,
        mainTaxonOnly: @main_taxon_only,
        speciesGroup: @species_group,
        withStats: @with_stats,
        withAllMatches: @with_all_matches,
        withVernaculars: @with_vernaculars
      }
      opts = args.delete_if { |_k, v| v.nil? }

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
