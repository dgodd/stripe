require "json"

module Stripe
  class Charge
    JSON.mapping(
      amount: Int32,
      currency: String,
      card: String,
      description: String
    )

    class Error
      JSON.mapping(
        type: String,
        message: String
      )
    end
    class Response
      JSON.mapping(
        id: String?,
        paid: Bool?,
        outcome: Hash(String, String?)?,
        error: Error?
      )
    end

    def self.create(hash)
      http_resp = Stripe::Api.client.post_form("/v1/charges", hash)
      resp = Charge::Response.from_json(http_resp.body)
      if resp.error
        raise resp.error.as(Error).message
      elsif resp.paid == false
        raise "Stripe did not charge the card"
      end
      resp
    end
  end
end
