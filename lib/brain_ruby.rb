require "brain_ruby/version"
require "httparty"
require "cgi"

module BrainRuby
  class Brain
    #include HTTParty

    def initialize(config = {})
      @api_key = config[:key] || raise('No API key!')
      @base_uri = config[:base_uri] || raise("Base URI expected!")
      @port = config[:port] || raise("Port number expected!")
    end

    def url(location, destination)
      response = HTTParty.get("#{@base_uri}:#{@port}/rest/url?apiKey=#{@api_key}&location=#{location}&destination=#{CGI.escape(destination)}")
      if response.code == 200
        response.body
      else
        nil
      end
    end
  end
end
