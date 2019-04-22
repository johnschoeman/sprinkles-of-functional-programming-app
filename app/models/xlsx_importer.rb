class XlsxImporter < FileImporter
  def import
    workbook = RubyXL::Parser.parse(filepath)
    worksheet = workbook.worksheets.first
    worksheet.each_with_index do |row, idx|
      if idx == 0
        next
      end
      formatted_data = builder.build(row)
      Product.create(formatted_data)
    end
  end
end
