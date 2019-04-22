class ProductDataImporter
  attr_reader :filepath, :formatter

  def initialize(filepath, formatter)
    @filepath = filepath
    @formatter = formatter
  end

  def import
    case File.extname(filepath)
    when ".csv"
      CsvImporter.new(filepath, formatter).import
    when ".xlsx"
      XlsxImporter.new(filepath, formatter).import
    else
      raise "Unknown file type"
    end
  end
end
