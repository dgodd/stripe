require "openssl"
require "http/client"

module Stripe
  class Api
    def self.client
      ctx = OpenSSL::SSL::Context::Client.new
      ctx.remove_options(ctx.options)
      ctx.add_options(LibSSL::Options::ALL |
                      LibSSL::Options::NO_SSLV2 |
                      LibSSL::Options::NO_SSLV3 |
                      LibSSL::Options::NO_TLSV1 |
                      LibSSL::Options::NO_TLSV1_1)
      client = HTTP::Client.new("api.stripe.com", 443, ctx)
      client.before_request do |request|
        request.headers["Authorization"] = "Basic #{Base64.strict_encode("#{Stripe.api_key}:")}"
      end
      client
    end
  end
end
