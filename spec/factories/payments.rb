FactoryGirl.define do
  factory :payment do
    payment_method "MyString"
card_type "MyString"
card_number "MyString"
expire_month 1
expire_year 1
name "MyString"
street "MyString"
city "MyString"
state "MyString"
postal_code "MyString"
country_code "MyString"
total "MyString"
currency "MyString"
description "MyString"
  end

end
