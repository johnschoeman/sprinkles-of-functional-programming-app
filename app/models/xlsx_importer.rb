class XlsxImporter < FileImporter
  def import
    Xlsx.foreach(filepath) do |row|
      formatted_data = formatter.build_xlsx(row)
      Product.create(formatted_data)
    end
  end

  private

  class Xlsx
    def self.foreach(filepath)
      workbook = RubyXL::Parser.parse(filepath)
      worksheet = workbook.worksheets.first
      worksheet.each_with_index do |row, idx|
        if idx == 0
          next
        end
        yield(row)
      end
    end
  end
end
