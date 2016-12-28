require "./spec_helper"

describe Stripe do
  it "has api_key property" do
    Stripe.api_key.should_not eq("asdf")
    Stripe.api_key = "asdf"
    Stripe.api_key.should eq("asdf")
  end
end
