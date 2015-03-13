# Create categories
Category.delete_all
category = Category.create(name: 'hair care', sort_order: 1)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'hair care.png'))
category.save!

category = Category.create(name: 'beauty', sort_order: 2)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'beauty.png'))
category.save!

category = Category.create(name: 'weight loss', sort_order: 3)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'weight loss.png'))
category.save!

category = Category.create(name: 'vitamins and minerals', sort_order: 4)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'vitamins and minerals.png'))
category.save!

category = Category.create(name: 'medication & remedies', sort_order: 5)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'medication & remedies.png'))
category.save!

category = Category.create(name: 'dental care', sort_order: 6)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'dental care.png'))
category.save!

category = Category.create(name: 'homeopathy', sort_order: 7)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'homeopathy.png'))
category.save!

category = Category.create(name: 'baby & child care', sort_order: 8)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'baby & child care.png'))
category.save!

category = Category.create(name: 'bath care', sort_order: 9)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'bath care.png'))
category.save!

category = Category.create(name: 'intimate hygiene', sort_order: 10)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'intimate hygiene.png'))
category.save!

category = Category.create(name: 'visual care', sort_order: 11)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'visual care.png'))
category.save!

category = Category.create(name: 'make up', sort_order: 12)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'make up.png'))
category.save!

category = Category.create(name: 'skin care', sort_order: 13)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'skin care.png'))
category.save!

category = Category.create(name: 'wellness', sort_order: 14)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'wellness.png'))
category.save!

category = Category.create(name: 'manicure & pedicure', sort_order: 15)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'manicure & pedicure.png'))
category.save!

category = Category.create(name: 'sex & sensuality', sort_order: 16)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'sex & sensuality.png'))
category.save!

category = Category.create(name: 'for women', sort_order: 17)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'for women.png'))
category.save!

category = Category.create(name: 'for men', sort_order: 18)
category.image = File.open(File.join(Rails.public_path, 'seed_data/categories', 'for men.png'))
category.save!

category = Category.create(name: 'product sets', sort_order: 19)
category.save!