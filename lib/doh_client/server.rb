# frozen_string_literal: true

require 'async/dns'

module DoHClient
  class Server < Async::DNS::Server
    attr_reader :client
    def initialize(resolver)
      super
      @client = resolver == "cloudflare" ? DoHClient::Client::Cloudflare : DoHClient::Client::Google
    end

    def process(name, resource_class, transaction)
      type = resource_class.to_s.split('::').last

      response = client.resolve(name, type: type)
      answers = response["Answer"]
      return transaction.fail!(:NXDomain) unless answers

      transaction.append_question!
      answers.each do |answer|
        next unless klass = Resolv::DNS::Resource.get_class(answer["type"], resource_class::ClassValue)
        resource = klass < Resolv::DNS::Resource::DomainName ? klass.new(Resolv::DNS::Name.create(answer["data"])) : klass.new(answer["data"])
        transaction.response.add_answer(answer["name"], answer["TTL"], resource)
      end
    end
  end
end
