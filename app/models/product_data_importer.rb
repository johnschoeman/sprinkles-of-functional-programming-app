class ProductDataImporter
  attr_reader :filepath, :formatter

  def initialize(filepath, formatter)
    @filepath = filepath
    @formatter = formatter
  end

  def import
    case File.extname(filepath)
    when ".csv"
      builder = CsvBuilder.new(formatter)
      CsvImporter.new(filepath, builder).import
    when ".xlsx"
      builder = XlsxBuilder.new(formatter)
      XlsxImporter.new(filepath, builder).import
    else
      raise "Unknown file type"
    end
  end
end
