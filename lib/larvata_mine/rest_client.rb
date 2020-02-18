require 'http'
require 'larvata_mine/maintenance_decorator'

module LarvataMine
  class RestClient
    attr_reader :api_key, :base_url, :timeout

    def initialize(**options)
      verify_config(**options)
      @client = HTTP.headers("X-Redmine-API-Key" => api_key).timeout(timeout)
    end

    def insert_maintenance(record)
      body = MaintenanceDecorator.new(record)
      @client.post("#{base_url}/issues.json", json: { issue: body.as_json })
    end

    def issues_by_project_id(id)
      @client.get("#{base_url}/issues.json?project_id=#{id}")
    end

    private

    def verify_config(**options)
      options = default_options.merge!(options)
      @api_key = options[:api_key]
      @base_url = options[:base_url]
      @timeout = options[:timeout]
      raise ArgumentError, "Missing API key and/or base URL" unless api_key && base_url
    end

    def default_options
      {
        api_key: ENV["REDMINE_API_KEY"],
        base_url: ENV["REDMINE_BASE_URL"],
        timeout: ENV["REDMINE_REQUEST_TIMEOUT"].to_i,
      }
    end
  end
end
