class PagesController < ApplicationController
  require 'open-uri'
  include PagesHelper
  def home
    @commits = JSON.load(open("https://api.github.com/users/dhh/events/public"))
    # render json: @commits
    # abort github.second.inspect
  end

  def verify_otp
  	# redirect_to products_path
  end

  def delete_all
  	Product.where(id: params["product_ids"]).destroy_all
  	redirect_to products_path
  end

  def import_or_export
  	
  end

  def home_page
    
  end

  def products_page
    
  end

  def find_orders
    boolean_value = params["boolean_value"]
    @products = find_all_orders(boolean_value)
  end
end
