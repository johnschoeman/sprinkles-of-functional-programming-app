class ProductImportWorker
  include Sidekiq::Worker

  def perform(file_path)
    ProductDataImporter.import(file_path)
  end
end
