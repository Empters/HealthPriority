FactoryGirl.define do
    sequence :name do |n|
      "Product_#{n}"
    end

    factory :product do
        name
        price 100
        status "green"
        stock_status_id 1
        manufacture_id 1
    end
end