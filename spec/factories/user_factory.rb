FactoryGirl.define do
  factory :user do
    email 'invisi@abv.bg'
    password '12345678'
    confirmed_at '2014-10-24 08:43:33'
    confirmation_sent_at '2014-10-24 08:43:20'
    gender_id 1
    first_name 'Test'
    last_name 'Test'
    country_id 1
    state_id 1
    city 'City'
    postal_code '100'
    address 'address'
    second_address 'second_address'
    phone '123'
    fax '321'
  end
end