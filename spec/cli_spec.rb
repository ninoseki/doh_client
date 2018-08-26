# frozen_string_literal: true

require "json"
require 'async/dns'
require "async/rspec"

RSpec.describe DoHClient::CLI, :vcr do
  describe "#resolve" do
    context "google" do
      it "should output a valid JSON" do
        output = capture(:stdout) { DoHClient::CLI.start %w(resolve github.com --resolver=google) }
        json = JSON.parse(output)
        expect(json).to be_a(Hash)
      end
    end
    context "cloudflare" do
      it "should output a valid JSON" do
        output = capture(:stdout) { DoHClient::CLI.start %w(resolve github.com --resolver=cloudflare) }
        json = JSON.parse(output)
        expect(json).to be_a(Hash)
      end
    end
  end
  describe "#act_as_server" do
    include_context Async::RSpec::Reactor

    it "should act as a server" do
      interfaces = [[:udp, "0.0.0.0", 5300], [:tcp, "0.0.0.0", 5300]]
      resolver = Async::DNS::Resolver.new(interfaces)
      task = DoHClient::CLI.start %w(act_as_server)

      %w(example.com github.com google.com).each do |name|
        resolved = resolver.addresses_for(name)
        resolved.each do |result|
          expect(result.address).to be_a(String)
        end
      end

      task.stop
    end
    it "should act as a server on a given port" do
      interfaces = [[:udp, "0.0.0.0", 5311], [:tcp, "0.0.0.0", 5311]]
      resolver = Async::DNS::Resolver.new(interfaces)
      task = DoHClient::CLI.start %w(act_as_server --port 5311)

      %w(example.com github.com google.com).each do |name|
        resolved = resolver.addresses_for(name)
        resolved.each do |result|
          expect(result.address).to be_a(String)
        end
      end

      task.stop
    end
  end
end
