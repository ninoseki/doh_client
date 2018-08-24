# frozen_string_literal: true

module DoHClient
  module Client
    class Google < Base
      def endpoint
        "https://dns.google.com/resolve"
      end

      def build_query(params)
        {
          name: params[:name],
          type: params[:type],
          cd: params[:cd],
          edns_client_subnet: params[:edns_client_subnet],
          random_padding: params[:random_padding]
        }.compact
      end
    end
  end
end
