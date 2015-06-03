class SpecialOffersController < ApplicationController

  def index

    # Init product list view parameters
    init_product_list_view(t('special_offers'), 12, 4, 'col-md-3 col-sm-4 col-xs-12')

    # Get spacial offers
    @products = Product.spacial_offers.paginate(:page => params[:page], :per_page => @products_per_page)

    respond_to do |format|
      format.html { render 'special_offers/index' }
    end
  end

end
