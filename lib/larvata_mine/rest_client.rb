require 'http'
require 'larvata_mine/maintenance_decorator'
require 'larvata_mine/properties_decorator'
require 'larvata_mine/issue_item_decorator'

module LarvataMine
  class RestClient
    attr_reader :api_key, :base_url, :timeout

    def initialize(**options)
      options = client_defaults.merge!(options)
      @api_key = options[:api_key]
      @base_url = options[:base_url]
      @timeout = options[:timeout]
      raise ArgumentError, 'Missing API key and/or base URL' unless api_key && base_url

      @client = HTTP.headers('X-Redmine-API-Key' => api_key).timeout(timeout)
      @uploads = HTTP.headers('X-Redmine-API-Key' => api_key, 'Content-Type' => 'application/octet-stream')
                     .timeout(timeout)
    end

    def insert_maintenance(record, upload_columns = {})
      body = MaintenanceDecorator.new(record)
      @client.post("#{base_url}/issues.json", json: { issue: body.as_json(upload_columns) })
    end

    def insert_issue_item(record, custom_fields = {})
      body = IssueItemDecorator.new(record)
      @client.post("#{base_url}/issues.json", json: { issue: body.as_json(custom_fields) })
    end

    def insert_properties(record)
      body = PropertiesDecorator.new(record)
      @client.post("#{base_url}/projects.json", json: { project: body.as_json })
    end

    def issues_by_project_id(id, options = {})
      options = query_defaults.merge(options)
      options[:project_id] = id
      @client.get("#{base_url}/issues.json", params: options)
    end

    def upload_file(file_location)
      @uploads.post("#{base_url}/uploads.json", body: File.open(file_location))
    end

    def projects_attribute(options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/projects.json", params: options)
    end

    def issues_attribute(options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/issues.json", params: options)
    end

    def search_attribute(attribute, options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/#{attribute}.json", params: options)
    end

    def insert_attribute(attribute, options = {})
      options = query_defaults.merge(options)
      @client.post("#{base_url}/#{attribute}.json", params: options)
    end

    def custom_fields_attribute
      @client.get("#{base_url}/custom_fields.json")
    end

    def tracker_attribute
      @client.get("#{base_url}/trackers.json")
    end

    def issues_update(id, options = {})
      @client.put("#{base_url}/issues/#{id}.json", json: { issue: options })
    end

    def attribute_update(id, attribute, options = {})
      @client.put("#{base_url}/#{attribute}/#{id}.json", json: options)
    end

    private

    def client_defaults
      {
        api_key: ENV['REDMINE_API_KEY'],
        base_url: ENV['REDMINE_BASE_URL'],
        timeout: ENV['REDMINE_REQUEST_TIMEOUT'].to_i
      }
    end

    def query_defaults
      {
        offset: 0,
        limit: 100
      }
    end
  end
end
