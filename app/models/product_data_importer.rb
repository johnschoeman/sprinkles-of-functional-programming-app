require "csv"

class ProductDataImporter
  attr_reader :filepath, :formatter

  def initialize(filepath, formatter)
    @filepath = filepath
    @formatter = formatter
  end

  def import
    case File.extname(filepath)
    when ".csv"
      import_csv
    when ".xlsx"
      import_xlsx
    end
  end

  private

  def import_csv
    CSV.foreach(filepath, headers: true) do |row|
      formatted_data = formatter.build_csv(row)
      Product.create(formatted_data)
    end
  end

  def import_xlsx
    workbook = RubyXL::Parser.parse(filepath)
    worksheet = workbook.worksheets.first
    worksheet.each_with_index do |row, idx|
      if idx == 0
        next
      end
      formatted_data = formatter.build_xlsx(row)
      Product.create(formatted_data)
    end
  end
end
