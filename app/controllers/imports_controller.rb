class ImportsController < ApplicationController
  def create
    ProductDataImporter.import(params[:file].path)
    redirect_to products_path, notice: "Succesfully imported"
  end
end
