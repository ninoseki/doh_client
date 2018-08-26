# frozen_string_literal: true
require 'async/dns'
require "async/rspec"

RSpec.describe DoHClient::Server, :vcr do
  include_context Async::RSpec::Reactor

  let(:interfaces) { [[:udp, '127.0.0.1', 8899]] }
  let(:server) { DoHClient::Server.new(interfaces) }
  let(:resolver) { Async::DNS::Resolver.new(interfaces) }

  it "should output DNS " do
    task = server.run

    %w(example.com github.com google.com).each do |name|
      resolved = resolver.addresses_for(name)
      resolved.each do |result|
        expect(result.address).to be_a(String)
      end
    end

    task.stop
  end
end
