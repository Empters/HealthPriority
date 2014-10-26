FactoryGirl.define do
    sequence :name do |n|
      "Product_#{n}"
    end

    factory :product do
        name
        price 100
        stock_status_id 1
        manufacturer_id 1
    end
end