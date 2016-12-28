require "./spec_helper"
require "webmock"

describe Stripe::Customer do
  describe "#list" do
    Spec.before_each do
      WebMock.stub(:get, "https://api.stripe.com/v1/customers").
        to_return(status: 200, body: File.read("spec/fixtures/v1_customers.json"))
    end

    it "returns an array" do
      customers = Stripe::Customer.list
      customers.should be_a(Array(Stripe::Customer))
      customer = customers.first
      customer.id.should eq "cus_9SwYzmZmXMk6bz"
      customer.sources.should be_a(Array(Stripe::Card))
      customer.sources.first.id.should eq "card_9SwSyeyUMACpBO"
      customer.subscriptions.should be_a(Array(Stripe::Subscription))
    end

    # it "calls /v1/customers on stripe" do
    #   Stripe.api_key = ENV["STRIPE_API_KEY"]
    #   resp = Stripe::Customer.list
    #   File.write("spec/fixtures/v1_customers.json",resp.body)
    # end
  end
end
