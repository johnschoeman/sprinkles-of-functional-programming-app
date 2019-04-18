class ProductImportWorker
  include Sidekiq::Worker

  def perform(file_path)
    Product.import(file_path)
  end
end
