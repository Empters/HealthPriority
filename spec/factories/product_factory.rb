FactoryGirl.define do
    factory :product do
        sequence(:name) {|n| "Product_#{n}"}
        price 100
        stock_status_id 1
        manufacturer_id 1
    end
end