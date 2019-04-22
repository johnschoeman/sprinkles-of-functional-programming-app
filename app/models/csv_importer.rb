require "csv"

class CsvImporter < FileImporter
  def import
    CSV.foreach(filepath, headers: true) do |row|
      formatted_data = formatter.build_csv(row)
      Product.create(formatted_data)
    end
  end
end
