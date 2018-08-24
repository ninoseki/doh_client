# frozen_string_literal: true

module DoHClient
  module Client
    class Cloudflare < Base
      def endpoint
        "https://cloudflare-dns.com/dns-query"
      end

      def build_query(params)
        {
          name: params[:name],
          type: params[:type],
          cd: params[:cd],
          do: params[:do]
        }.compact
      end

      def validate(query)
        super(query)
        raise ArgumentError, "do must be a boolean value" if query[:do] && !boolean?(query[:do])
      end
    end
  end
end
