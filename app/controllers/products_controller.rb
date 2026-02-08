class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    # 🔍 SEARCH
    if params[:search].present?
      @products = @products.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # 🏷 CATEGORY FILTER
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
