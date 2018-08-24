# frozen_string_literal: true

require "thor"

module DoHClient
  class CLI < Thor
    class_option :resolver, type: :string

    desc "resolve [NAME]", "resolve a given name"
    method_option :cd, type: :boolean
    method_option :do, type: :boolean
    method_option :edns_client_subnet, type: :string
    method_option :random_padding, type: :string
    def resolve(name)

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
