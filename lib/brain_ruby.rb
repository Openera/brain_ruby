require "httparty"
require "cgi"

Dir[File.dirname(__FILE__) + '/brain_ruby/*.rb'].each { |file| require file } 

module BrainRuby
  @@config = { api_key: nil, base_uri: nil, port: nil }
  @@valid_config_keys = @@config.keys

  class << self
    def configure(opts = {})
      opts.each { |k,v| @@config[k.to_sym] = v if @@valid_config_keys.include?(k.to_sym) }
      raise 'No API key!' unless @@config[:api_key]
      raise 'Base URI expected!' unless @@config[:base_uri]
      raise 'Port number expected!' unless @@config[:port]
    end

    def configure_with(path_to_yaml_file)
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      raise 'YAML configuration file could not be found. Using defaults.'
    rescue Psych::SyntaxError
      raise 'YAML configuration file contains invalid syntax. Using defaults.'
    else
      configure(config)	
    end

    def url(location, destination)
      response = HTTParty.get("#{@base_uri}:#{@port}/rest/url?apiKey=#{@api_key}&location=#{location}&destination=#{CGI.escape(destination)}", verify: false)
      if response.code == 200
        response.body
      else
        nil
      end

    def config
      @@config
    end
  end
end
