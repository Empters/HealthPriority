class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :init_root_categories

  # Lazy loading init root categories
  def init_root_categories
    $root_categories ||= Category.top_level
  end
end
