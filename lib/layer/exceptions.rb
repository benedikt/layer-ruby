module Layer
  module Exceptions

    def self.build_exception(original_exception)
      identifier = JSON.parse(original_exception.http_body)['id']
      identifier.gsub!(/(?:_|(\/)|^)([a-z\d]*)/i) { $2.capitalize }

      exception = const_get(identifier) rescue self
      exception.new(original_exception)
    rescue
      original_exception
    end

    class Exception < RuntimeError
      attr_reader :original_exception

      def initialize(original_exception = nil)
        @original_exception = original_exception
      end

      def message
        "#{original_exception.message}\n\n#{JSON.pretty_generate(response_json)}\n\n"
      end

      def response_json
        JSON.parse(original_exception.http_body)
      end
    end

    class ClientException < Exception; end
    class ServiceUnavailable < ClientException; end
    class InvalidAppId< ClientException; end
    class InvalidRequestId < ClientException; end
    class AuthenticationRequired < ClientException; end
    class AppSuspended < ClientException; end
    class UserSuspended < ClientException; end
    class RateLimitExceeded < ClientException; end
    class RequestTimeout < ClientException; end
    class InvalidOperation < ClientException; end
    class InvalidRequest < ClientException; end
    class InvalidEndpoint < ClientException; end
    class InvalidHeader < ClientException; end

    class ResourceException < Exception; end
    class AccessDenied < ResourceException; end
    class NotFound < ResourceException; end
    class ObjectDeleted < ResourceException; end
    class MissingProperty < ResourceException; end
    class InvalidProperty < ResourceException; end
    class Conflict < ResourceException; end
  end
end
