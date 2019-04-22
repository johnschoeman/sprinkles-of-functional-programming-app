class XlsxBuilder < ProductDataBuilder
  HEADERS = %w[name author release_date value version active].freeze

  def build(xlsx_row)
    cells = xlsx_row.cells.map(&:value)
    data = HEADERS.zip(cells).to_h.symbolize_keys
    formatter.format(data)
  end
end
