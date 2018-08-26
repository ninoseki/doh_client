# frozen_string_literal: true

RSpec.describe DoHClient::Client::Google, :vcr do
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
        hash = subject.resolve("example.com", type: "A", edns_client_subnet: "0.0.0.0/0", random_padding: "XmkMw~o_mgP2pf.gpw-Oi5dK")
        expect(hash).to be_a(Hash)
        expect(hash.dig("Status")).to eq(0)
        expect(hash.dig("Answer").first.dig("name")).to eq("example.com.")
      end
    end
  end
end
