require 'paypal-sdk-rest'

class ShoppingCartsController < ApplicationController

  include PayPal::SDK::REST

  # Start breadcrumb root
  add_breadcrumb 'Home', :root_path

  # Index action
  def index
    add_breadcrumb 'Cart', :shopping_carts_path
  end

  def pay
    puts "--------- pay ------------"
    puts request.original_url

    success
    # credit_card_payment
    # paypal_payment
    # if @payment.create
    #   puts "!!!!!!!!!!!!!!!!!!  id is = "
    #   puts @payment.id # Payment Id
    # else
    #   puts "!!!!!!!!!!!!!!!!!!  ERROR is = "
    #   puts @payment.error # Error Hash
    # end
    #
    # render :nothing
    redirect_to '/shopping_carts/cancel'
  end

  def success
    puts "--------- success ------------"
  end

  def cancel
    puts "--------- cancel ------------"
  end

  # ###Payment
  # A Payment Resource; create one using
  # the above types and intent as `sale or `authorize`
  def credit_card_payment
    @payment = Payment.new({
       :intent => "sale",

       # ###Payer
       # A resource representing a Payer that funds a payment
       # Use the List of `FundingInstrument` and the Payment Method
       # as 'credit_card'
       :payer => {
           :payment_method => "credit_card",

           # ###FundingInstrument
           # A resource representing a Payeer's funding instrument.
           # Use a Payer ID (A unique identifier of the payer generated
           # and provided by the facilitator. This is required when
           # creating or using a tokenized funding instrument)
           # and the `CreditCardDetails`
           :funding_instruments => [{

                # ###CreditCard
                # A resource representing a credit card that can be
                # used to fund a payment.
                :credit_card => {
                    :type => "visa",
                    :number => "4417119669820331",
                    :expire_month => "11",
                    :expire_year => "2018",
                    :cvv2 => "874",
                    :first_name => "Joe",
                    :last_name => "Shopper",

                    # ###Address
                    # Base Address used as shipping or billing
                    # address in a payment. [Optional]
                    :billing_address => {
                        :line1 => "52 N Main ST",
                        :city => "Johnstown",
                        :state => "OH",
                        :postal_code => "43210",
                        :country_code => "US"}}}]},
       # ###Transaction
       # A transaction defines the contract of a
       # payment - what is the payment for and who
       # is fulfilling it.
       :transactions => [{

           # Item List
           :item_list => {
               :items => [{
                              :name => "item",
                              :sku => "item",
                              :price => "1",
                              :currency => "USD",
                              :quantity => 1}]},

           # ###Amount
           # Let's you specify a payment amount.
           :amount => {
               :total => "1.00",
               :currency => "USD"},
           :description => "This is the payment transaction description."}]})
  end


  # ###Payment
  # A Payment Resource; create one using
  # the above types and intent as 'sale'
  def paypal_payment
    @payment = Payment.new({
       :intent =>  "sale",

       # ###Payer
       # A resource representing a Payer that funds a payment
       # Payment Method as 'paypal'
       :payer =>  {
           :payment_method =>  "paypal" },

       # ###Redirect URLs
       :redirect_urls => {
           :return_url => "http://localhost:3000/payment/execute",
           :cancel_url => "http://localhost:3000/" },

       # ###Transaction
       # A transaction defines the contract of a
       # payment - what is the payment for and who
       # is fulfilling it.
       :transactions =>  [{

          # Item List
          :item_list => {
              :items => [{
                 :name => "item",
                 :sku => "item",
                 :price => "5",
                 :currency => "USD",
                 :quantity => 1 }]},

          # ###Amount
          # Let's you specify a payment amount.
          :amount =>  {
              :total =>  "5",
              :currency =>  "USD" },
          :description =>  "This is the payment transaction description." }]})
  end
end
