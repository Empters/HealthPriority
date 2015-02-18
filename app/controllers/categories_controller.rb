class CategoriesController < InheritedResources::Base

  def index
    @categories = Category.all
  end

end
