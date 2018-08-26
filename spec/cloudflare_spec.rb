# frozen_string_literal: true

RSpec.describe DoHClient::Client::Cloudflare, :vcr do
  describe "#get" do
    context "without options" do
      it "should return a hash" do
        hash = subject.resolve("example.com", type: "A")
        expect(hash).to be_a(Hash)
        expect(hash.dig("Status")).to eq(0)
        expect(hash.dig("Answer").first.dig("name")).to eq("example.com.")
      end
    end
    context "with options" do
      it "should return a hash" do
        hash = subject.resolve("example.com", type: "A", do: true, cd: false)
        expect(hash).to be_a(Hash)
        expect(hash.dig("Status")).to eq(0)
        expect(hash.dig("Answer").first.dig("name")).to eq("example.com.")
      end
    end
  end
end
