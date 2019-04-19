class ImportsController < ApplicationController
  def create
    importer = ProductDataImporter.new(params[:file].path)
    importer.import
    redirect_to products_path, notice: "Succesfully imported"
  end
end
