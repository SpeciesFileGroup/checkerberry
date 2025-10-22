# frozen_string_literal: true

require "faraday"

module Faraday
  class CheckerberryErrors < Faraday::Middleware
    def on_complete(env)
      @env = env
      case env[:status]
      when 400
        raise Checkerberry::RequestError, error_message
      when 401
        raise Checkerberry::Unauthorized, error_message
      when 404
        raise Checkerberry::NotFound, error_message
      when 500
        raise Checkerberry::InternalServerError, error_message
      when 502
        raise Checkerberry::BadGateway, error_message
      when 503
        raise Checkerberry::ServiceUnavailable, error_message
      end
    end

    def error_message
      "#{@env[:method].to_s.upcase} #{@env[:url]}: #{@env[:status]} - #{@env[:body]}"
    end

    class Middleware < CheckerberryErrors
    end
  end
end
