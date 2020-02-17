require "larvata_mine/rest_client"
require "webmock/rspec"
require "dotenv/load"

RSpec.describe LarvataMine::RestClient do
  context "without a Redmine API key" do
    it "raises ArgumentError" do
      base_url = "https://fake.com"
      expect { LarvataMine::RestClient.new(api_key: nil, base_url: base_url) }.to raise_error ArgumentError
    end
  end

  context "without a Redmine base URL" do
    it "raises ArgumentError" do
      api_key = "fake"
      expect { LarvataMine::RestClient.new(api_key: api_key, base_url: nil) }.to raise_error ArgumentError
    end
  end

  context "with an invalid Redmine API key" do
    it "responds with a redirect to login" do
      api_key = "fake"
      id = "s-maintenance"
      client = LarvataMine::RestClient.new(api_key: api_key)

      stub_request(:get, "#{client.base_url}/issues.json?project_id=#{id}")
        .with(headers: { "X-Redmine-API-Key" => api_key })
        .to_return(status: 302)
      response = client.issues_by_project_id(id)

      expect(response.code).to eq 302
    end
  end

  context "with a valid Redmine API key" do
    it "creates a maintenance issue in Redmine" do
      issue = LarvataMine::MaintenanceDecorator.new(MaintenanceFake.new)
      client = LarvataMine::RestClient.new

      stub_request(:post, "#{client.base_url}/issues.json")
        .with(body: issue.to_json, headers: { "X-Redmine-API-Key" => client.api_key })
        .to_return(status: 201)
      response = client.insert_maintenance(issue)

      expect(response.code).to eq 201
    end

    it "gets issues by project ID" do
      id = "s-maintenance"
      client = LarvataMine::RestClient.new

      stub_request(:get, "#{client.base_url}/issues.json?project_id=#{id}")
        .with(headers: { "X-Redmine-API-Key" => client.api_key })
      response = client.issues_by_project_id(id)

      expect(response.code).to eq 200
    end
  end
end
