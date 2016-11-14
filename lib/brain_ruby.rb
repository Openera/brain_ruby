require "brain_ruby/version"
require "httparty"
require "cgi"

module BrainRuby
  class Brain
    include HTTParty

    def initialize(config = {})
      @api_key = config[:key] || raise('No API key!')
      @base_uri = config[:base_uri] || raise("Base URI expected!")
    end

    def url(location, destination)
      response = HTTParty.get("#{@base_uri}:8443/rest/url?apiKey=#{@api_key}&location=#{location}&destination=#{CGI.escape(destination)}")

      response.body
    end
  end
end
