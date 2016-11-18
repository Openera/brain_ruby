module BrainRuby
  class Requests
    def self.url(location, destination, opts={})
      api_key, base_uri, port = BrainRuby.config[:api_key], BrainRuby.config[:base_uri], BrainRuby.config[:port]

      response = HTTParty.get("#{base_uri}:#{port}/rest/url?apiKey=#{api_key}&location=#{location}&destination=#{CGI.escape(destination)}", opts)
      if response.code == 200
        response.body
      else
        nil
      end
    end
  end
end