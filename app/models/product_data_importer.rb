class ProductDataImporter
  attr_reader :filepath, :formatter

  def initialize(filepath, formatter)
    @filepath = filepath
    @formatter = formatter
  end

  def import
    CSV.foreach(filepath, headers: true) do |row|
      formatted_data = formatter.build(row)
      Product.create(formatted_data)
    end
  end
end
