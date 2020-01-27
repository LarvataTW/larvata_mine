require 'http'

module LarvataMine
  class RestClient
    attr_reader :api_key, :base_url

    def initialize(**options)
      verify_config(**options)
      @client = HTTP.headers("X-Redmine-API-Key" => api_key)
    end

    def all_issues
      @client.get("#{base_url}/issues.json")
    end

    private

    def verify_config(**options)
      @api_key = options.fetch(:api_key) { ENV["REDMINE_API_KEY"] }
      @base_url = options.fetch(:base_url) { ENV["REDMINE_BASE_URL"] }
      raise ArgumentError, "Missing API key and/or base URL" unless api_key && base_url
    end
  end
end
