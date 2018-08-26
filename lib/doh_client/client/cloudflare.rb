# frozen_string_literal: true

module DoHClient
  module Client
    class Cloudflare < Base
      def endpoint
        "https://cloudflare-dns.com/dns-query"
      end

      def build_query(name, options)
        {
          name: name,
          type: options[:type],
          cd: options[:cd],
          do: options[:do]
        }.compact
      end

      def validate(query)
        super(query)
        raise ArgumentError, "do must be a boolean value" if query[:do] && !boolean?(query[:do])
      end
    end
  end
end
