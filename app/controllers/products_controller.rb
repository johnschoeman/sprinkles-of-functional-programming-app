class ProductsController < ApplicationController
  def index
    products = Product.all

    render locals: { products: products }
  end

  def new
    product = Product.new

    render locals: { product: product }
  end

  def create
    product = Product.new(product_params)

    if product.save
      flash[:success] = "Product created"
      redirect_to products_path
    else
      flash[:error] = product.errors.full_messages
      render new, locals: { product: product }
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    flash[:success] = "Product destroyed"
    redirect_to products_path
  end

  def edit
    product = Product.find(params[:id])

    if product
      render locals: { product: product }
    else
      flash[:error] = "Product not found"
      redirect_to products_path
    end
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      flash[:success] = "Product updated"
      redirect_to products_path
    else
      flash[:error] = product.errors.full_messages
      redirect_to products_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :date, :version, :value, :author)
  end
end
