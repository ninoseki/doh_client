# frozen_string_literal: true

RSpec.describe DoHClient::Client::Google, :vcr do
  describe "#get" do
    it "should return a hash" do
      expect(subject.get(name: "github.com", type: "A")).to be_a(Hash)
    end
  end
end
