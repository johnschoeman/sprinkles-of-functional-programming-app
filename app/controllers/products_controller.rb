class ProductsController < ApplicationController
  def index
    products = Product.all

    render locals: { products: products }
  end
end
