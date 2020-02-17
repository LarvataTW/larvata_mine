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
      @client.post("#{base_url}/issues.json", body: body.to_json)
    end

    def issues_by_project_id(id)
      @client.get("#{base_url}/issues.json?project_id=#{id}")
    end

    private

    def verify_config(**options)
      @api_key = options.fetch(:api_key) { ENV["REDMINE_API_KEY"] }
      @base_url = options.fetch(:base_url) { ENV["REDMINE_BASE_URL"] }
      @timeout = options.fetch(:timeout) { ENV["REQUEST_TIMEOUT"].to_i }
      raise ArgumentError, "Missing API key and/or base URL" unless api_key && base_url
    end
  end
end
