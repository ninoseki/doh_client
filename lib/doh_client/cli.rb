# frozen_string_literal: true

require "thor"
require "json"

module DoHClient
  class CLI < Thor
    class_option :resolver, type: :string, desc: "a resolver to use ('google' or 'cloudflare', default: google)"

    desc "resolve [NAME]", "resolve a given name"
    method_option :type, type: :string, default: "A"
    method_option :cd, type: :boolean
    method_option :do, type: :boolean
    method_option :edns_client_subnet, type: :string
    method_option :random_padding, type: :string
    def resolve(name)
      hash = resolver.resolve(name, options)
      puts hash.to_json
    end

    desc "act_as_server", "act as a local DNS server on a given port (default: 5300)"
    method_option :port, type: :numeric, default: 5300
    def act_as_server
      port = options[:port]
      interfaces = [[:udp, "0.0.0.0", port], [:tcp, "0.0.0.0", port]]
      server = DoHClient::Server.new(interfaces)
      puts "Starting DNS server 0.0.0.0:#{port} (tcp/udp)"
      begin
        server.run
      rescue Interrupt
        puts "\nStopping DNS server..."
      ensure
        puts "Stopped"
      end
    end

    no_commands do
      def resolver
        case options[:resolver]
        when "google"
          DoHClient::Client::Google
        when "cloudflare"
          DoHClient::Client::Cloudflare
        else
          DoHClient::Client::Google
        end
      end

      def with_error_handling
        yield
      rescue ResponseError => e
        puts "Warning: #{e}"
      rescue ArgumentError => _
        puts "Warning: #{e}"
      end
    end
  end
end
