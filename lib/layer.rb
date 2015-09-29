require 'layer/version'
require 'layer/client'
require 'layer/patch'
require 'layer/operations'
require 'layer/resource'
require 'layer/relation_proxy'
require 'layer/conversation'
require 'layer/message'
require 'layer/user'
require 'layer/block'
require 'layer/announcement'

module Layer
  class Exception < RuntimeError
  end

  class ClientException < Exception
    attr_reader :original_exception

    def initialize(original_exception)
      @original_exception = original_exception
    end

    def message
      "#{original_exception.message}\n\n#{JSON.pretty_generate(json)}\n\n"
    end

    def json
      JSON.parse(original_exception.http_body)
    end

  end
end
