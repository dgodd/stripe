require "./spec_helper"
# require "webmock"

describe Stripe::Charge do
  describe ".create" do
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    resp = Stripe::Charge.create({
      "amount" => 5500, # amount in cents, again
      "currency" => "usd",
      "card" => "STRIPE_TOKEN",
      "description" => "d@d.com"
    })
    pp resp
  end
end
