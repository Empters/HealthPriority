namespace :export do

  # Command to start export -> 'rake export:seeds_format > db/seeds.rb'
  desc 'Export DB data to seed file'

  # Task to
  task :seeds_format => :environment do

    # Export category
    Category.order(:id).all.each do |category|
      puts "Category.create(#{category.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end

    # Export product
    Product.order(:id).all.each do |product|
      puts "Product.create(#{product.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end

  end

end