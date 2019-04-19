class ImportsController < ApplicationController
  def create
    formatter = ProductDataFormatter.new
    importer = ProductDataImporter.new(params[:file].path, formatter)
    importer.import
    redirect_to products_path, notice: "Succesfully imported"
  end
end
