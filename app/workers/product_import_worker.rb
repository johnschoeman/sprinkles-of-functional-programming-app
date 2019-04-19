class ProductImportWorker
  include Sidekiq::Worker

  def perform(file_path)
    formatter = ProductDataFormatter.new
    Product.import(file_path, formatter)
  end
end
