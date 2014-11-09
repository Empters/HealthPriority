FactoryGirl.define do
  factory :web_store_detail do
    contact File.read(File.join(Rails.public_path, 'seed_data',  'contact' + '.htm'))
    delivery File.read(File.join(Rails.public_path, 'seed_data',  'delivery' + '.htm'))
    faq File.read(File.join(Rails.public_path, 'seed_data',  'faq' + '.htm'))
    about_us File.read(File.join(Rails.public_path, 'seed_data',  'about_us' + '.htm'))
  end
end
