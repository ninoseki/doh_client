# frozen_string_literal: true

RSpec.describe DoHClient::Client::Base, :vcr do
  subject { DoHClient::Client::Base.new }
  describe "#validate" do
    it "should raise an ArgumentError when given an invaid query" do
      q = { type: "A" }
      expect { subject.validate q }.to raise_error(ArgumentError)
      q = { name: "example.com" }
      expect { subject.validate q }.to raise_error(ArgumentError)

      q = { name: "example.com", type: "A", cd: "invalid"}
      expect { subject.validate q }.to raise_error(ArgumentError)
      q = { name: "example.com", type: "A", cd: false }
      subject.validate q
    end
  end
end
