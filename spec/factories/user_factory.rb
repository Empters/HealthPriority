FactoryGirl.define do
  factory :user do
    email 'invisi@abv.bg'
    password '12345678'
    confirmed_at '2014-10-24 08:43:33'
    confirmation_sent_at '2014-10-24 08:43:20'
    gender_id 1
    country_id 1
  end
end