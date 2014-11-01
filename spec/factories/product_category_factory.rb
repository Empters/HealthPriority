FactoryGirl.define do
    factory :product_category do
        sequence(:product_id) {|n| n}
        sequence(:category_id) {|n| n}
    end
end