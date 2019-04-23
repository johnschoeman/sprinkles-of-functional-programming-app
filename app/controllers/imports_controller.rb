class ImportsController < ApplicationController
  def create
    ProductsImporter.import(params[:file].path)
    redirect_to products_path, notice: "Succesfully imported"
  end
end
