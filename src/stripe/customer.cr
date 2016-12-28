require "json"

module Stripe
  class Card
    JSON.mapping(
      id: String,
      object: String
    )
  end
  class Subscription
    JSON.mapping(
      id: String,
      object: String
    )
  end
  class Customer
    JSON.mapping(
      id: String,
      default_source: String,
      delinquent: Bool,
      description: String,
      email: String,
      livemode: Bool,
      metadata: Hash(String, JSON::Any),
      shipping: JSON::Any,
      sources: {type: Array(Card), root: "data", default: [] of Card},
      subscriptions: {type: Array(Subscription), root: "data", default: [] of Subscription}
    )

    def self.list
      resp = Stripe::Api.client.get("/v1/customers")
      Array(Customer).from_json(resp.body, "data")
    end
  end
end
