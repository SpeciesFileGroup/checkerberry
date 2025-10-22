# frozen_string_literal: true

module Checkerberry
  class Error < StandardError; end
  class RequestError < Error; end
  class Unauthorized < Error; end
  class NotFound < Error; end
  class InternalServerError < Error; end
  class BadGateway < Error; end
  class ServiceUnavailable < Error; end
end
