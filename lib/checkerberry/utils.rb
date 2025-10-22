# frozen_string_literal: true

module Checkerberry
  module Utils
    def make_user_agent
      requa = "Faraday/v" + Faraday::VERSION
      habua = "Checkerberry/v" + Checkerberry::VERSION
      if Checkerberry.mailto
        mailto = "mailto:" + Checkerberry.mailto
        ua = requa + " " + habua + " " + mailto
      else
        ua = requa + " " + habua
      end
      ua
    end
  end
end
