# frozen_string_literal: true

module DoHClient
  module Client
    class Request
      def get(url, query)
        res = http.headers(headers).get(url, params: query);
        return JSON.parse(res.body.to_s) if res.code == 200
        raise ResponseError, res.body.to_s
      end

      def headers
        {
          accept: "application/dns-json",
          user_agent: "curl/7.54.0"
        }
      end

      def http
        if proxy = ENV["HTTPS_RPOXY"] || ENV["https_proxy"]
          uri = URI(proxy)
          HTTP.via(uri.hostname, uri.port)
        else
          HTTP
        end
      end

      def self.get(url, query)
        new.get(url, query);
      end
    end
  end
end
