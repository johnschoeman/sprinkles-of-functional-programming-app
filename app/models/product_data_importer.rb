class ProductDataImporter
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def import
    CSV.foreach(filepath, headers: true) do |row|
      data = row.to_h
      data["active"] = data["active"] == "true"
      Product.create(data)
    end
  end
end
