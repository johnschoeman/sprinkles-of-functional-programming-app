class ProductDataFormatter
  HEADERS = %w[name author release_date value version active].freeze

  def build_csv(csv_row)
    data = csv_row.to_h.symbolize_keys
    build(data)
  end

  def build_xlsx(xlsx_row)
    cells = xlsx_row.cells.map(&:value)
    data = HEADERS.zip(cells).to_h.symbolize_keys
    build(data)
  end

  private

  def build(data)
    data[:active] = data[:active] == "true"
    data[:release_date] = parse_release_date(data[:release_date])
    data[:value] = data[:value].to_i
    data
  end

  def parse_release_date(input)
    if input.is_a?(Float)
      Time.zone.parse(input.to_i.to_s)
    elsif input.is_a?(DateTime)
      input
    else
      Time.zone.parse(input)
    end
  end
end
