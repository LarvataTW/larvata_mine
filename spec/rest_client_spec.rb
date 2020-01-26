require "larvata_mine/rest_client"
require "webmock/rspec"
require "dotenv"

RSpec.describe LarvataMine::RestClient do
  context "without a Redmine API key" do
    it "raises ArgumentError" do
      base_url = "https://fake.com"
      expect { LarvataMine::RestClient.new(base_url: base_url) }.to raise_error ArgumentError
    end
  end

  context "without a Redmine base URL" do
    it "raises ArgumentError" do
      api_key = "fake"
      expect { LarvataMine::RestClient.new(api_key: api_key) }.to raise_error ArgumentError
    end
  end

  context "with an invalid Redmine API key" do
    it "responds with a redirect to login" do
      Dotenv.load
      api_key = "fake"
      client = LarvataMine::RestClient.new(api_key: api_key)

      stub_request(:get, "#{client.base_url}/issues")
        .with(headers: { "X-Redmine-API-Key" => api_key })
        .to_return(status: 302)
      response = client.all_issues

      expect(response.code).to eq 302
    end
  end

  context "with a valid Redmine API key" do
    it "gets all issues" do
      Dotenv.load
      client = LarvataMine::RestClient.new

      stub_request(:get, "#{client.base_url}/issues")
        .with(headers: { "X-Redmine-API-Key" => client.api_key })
      response = client.all_issues

      expect(response.code).to eq 200
    end
  end
end
