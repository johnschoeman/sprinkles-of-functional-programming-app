class XlsxImporter
  attr_reader :filepath, :formatter

  def initialize(filepath, formatter)
    @filepath = filepath
    @formatter = formatter
  end

  def import
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
