require "json"

RSpec.describe DoHClient::CLI, :vcr do
  context "google" do
    describe "#resolve" do
      it "should output a valid JSON" do
        output = capture(:stdout) { DoHClient::CLI.start %w(resolve github.com --resolver=google) }
        json = JSON.parse(output)
        expect(json).to be_a(Hash)
      end
    end
  end
  context "cloudflare" do
    describe "#resolve" do
      it "should output a valid JSON" do
        output = capture(:stdout) { DoHClient::CLI.start %w(resolve github.com --resolver=cloudflare) }
        json = JSON.parse(output)
        expect(json).to be_a(Hash)
      end
    end
  end
end
