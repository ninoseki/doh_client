# frozen_string_literal: true

module DoHClient
  module Client
    class Google < Base
      def endpoint
        "https://dns.google.com/resolve"
      end

      def build_query(name, options)
        {
          name: name,
          type: options[:type],
          cd: options[:cd],
          edns_client_subnet: options[:edns_client_subnet],
          random_padding: options[:random_padding]
        }.compact
      end
    end
  end
end
