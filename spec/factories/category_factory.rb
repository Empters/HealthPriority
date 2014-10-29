FactoryGirl.define do
    factory :category do

        transient do
          is_top? true
          sub_categies_cout 3
        end

        sequence(:name){|n|
          if is_top?
            "Category_#{n}"
          else
            "#{parent.name}_#{n}"
          end
        }

        parent nil

        after(:create) do |category, evaluator|
          if evaluator.is_top?
            parent = nil
            children = create_list(:category, evaluator.sub_categies_cout, is_top?: false, parent: category)
          else
            parent = evaluator.parent
          end
        end
    end
end