require "csv"

class ProductDataImporter
  HEADERS = %w[name author release_date value version active].freeze

  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    case File.extname(filepath)
    when ".csv"
      import_csv(filepath)
    when ".xlsx"
      import_xlsx(filepath)
    else
      raise "Unknown file type"
    end
  end

  private

  def import_csv(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      data = row.to_h.symbolize_keys
      process_data(data)
    end
  end

  def import_xlsx(filepath)
    workbook = RubyXL::Parser.parse(filepath)
    worksheet = workbook.worksheets.first
    worksheet.each_with_index do |row, idx|
      if idx == 0
        next
      end
      cells = row.cells.map(&:value)
      data = HEADERS.zip(cells).to_h.symbolize_keys
      process_data(data)
    end
  end

  def process_data(data)
    parse_active(data).then { |data| parse_release_date(data) }.then do |data|
      Product.create(data)
    end
  end

  def parse_active(data)
    data[:active] = !!data[:active]
    data
  end

  def parse_release_date(data)
    data[:release_date] = Time.zone.parse(data[:release_date].to_i.to_s)
    data
  end
end
