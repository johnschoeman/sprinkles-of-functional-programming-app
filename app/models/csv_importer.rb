require "csv"

class CsvImporter < FileImporter
  def import
    CSV.foreach(filepath, headers: true) do |row|
      built_data = builder.build(row)
      Product.create(built_data)
    end
  end
end
