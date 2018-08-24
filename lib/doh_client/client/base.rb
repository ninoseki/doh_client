# frozen_string_literal: true

require "json"
require "http"

module DoHClient
  module Client
    class Base
      def get(params)
        query = build_query(params)
        validate(query)
        Request.get(endpoint, query)
      end

      def self.get(params)
        new.get(params)
      end

      def endpoint
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def build_query
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def validate(query)
        raise ArgumentError, "name is a required parameter" if query[:name].nil?
        raise ArgumentError, "type is a required parameter" if query[:type].nil?
        raise ArgumentError, "cd must be a boolean value" if query[:cd] && !boolean?(query[:cd])
      end

      private

      def boolean?(param)
        [true, false].include? param
      end
    end
  end
end
