require 'http'
require 'larvata_mine/maintenance_decorator'
require 'larvata_mine/properties_decorator'

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
      @image_token = {}
    end

    def insert_maintenance(record)
      body = MaintenanceDecorator.new(record)
      @client.post("#{base_url}/issues.json", json: { issue: body.as_json(@image_token) })
    end

    def insert_properties(record)
      body = PropertiesDecorator.new(record)
      @client.post("#{base_url}/projects.json", json: { project: body.as_json })
    end

    def insert_estimate_item(record, custom_fields = {})
      body = EstimateItemDecorator.new(record)
      @client.post("#{base_url}/projects.json", json: { issue: body.as_json(custom_fields) })
    end

    def issues_by_project_id(id, options = {})
      options = query_defaults.merge(options)
      options[:project_id] = id
      @client.get("#{base_url}/issues.json", params: options)
    end

    def get_projects(options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/projects.json", params: options)
    end

    def get_custom_field(options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/custom_fields.json", params: options)
    end

    def get_tracker(options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/trackers.json", params: options)
    end

    def free_search(target, options = {})
      options = query_defaults.merge(options)
      @client.get("#{base_url}/#{target}.json", params: options)
    end

    def upload_file(record, url = {})
      record.attachments.each do |image|
        file_location = url.present? ? url[image.id] : check_attachment_detail(image)
        raise ArgumentError, 'File Location Fail' if file_location.nil?

        respone = @uploads.post('https://redmine.pingshih.com/uploads.json', body: File.open(file_location))
        @image_token[image.id] = JSON.parse(respone)['upload']['token']
      end
    end

    private

    def client_defaults
      {
        api_key: ENV["REDMINE_API_KEY"],
        base_url: ENV["REDMINE_BASE_URL"],
        timeout: ENV["REDMINE_REQUEST_TIMEOUT"].to_i,
      }
    end

    def query_defaults
      {
        offset: 0,
        limit: 50,
      }
    end

    def check_attachment_detail(image)
      return if image.attachment.nil? || image.attachment_file_name.nil?

      "./public#{image.attachment.url.match(/.+\//)[0]}#{image.attachment_file_name}"
    end
  end
end
