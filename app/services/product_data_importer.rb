require "csv"

class ProductDataImporter
  HEADERS = %w[name author release_date value version active].freeze

  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    read_file(filepath).
      map { |data| process_data(data) }.
      map { |data| Product.create(data) }
  end

  private

  def read_file(filepath)
    case File.extname(filepath)
    when ".csv"
      read_csv(filepath)
    when ".xlsx"
      read_xlsx(filepath)
    else
      raise "Unknown file type"
    end
  end

  def read_csv(filepath)
    results = []
    CSV.foreach(filepath, headers: true) do |row|
      results << row.to_h.symbolize_keys
    end
    results
  end

  def read_xlsx(filepath)
    results = []
    foreach_xlsx(filepath) do |row|
      cells = row.cells.map(&:value)
      data = HEADERS.zip(cells).to_h.symbolize_keys
      results << data
    end
    results
  end

  def process_data(data)
    parse_active(data).
      then { |data| parse_value(data) }.
      then { |data| parse_release_date(data) }
  end

  def parse_active(data)
    data[:active] = !!data[:active]
    data
  end

  def parse_release_date(data)
    release_date = data[:release_date]
    if release_date.is_a?(String)
      data[:release_date] = Time.zone.parse(release_date)
    end
    data
  end

  def parse_value(data)
    value = data[:value].to_s
    data[:value] = value.gsub(/^\$/, "").to_i
    data
  end

  def foreach_xlsx(filepath)
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
