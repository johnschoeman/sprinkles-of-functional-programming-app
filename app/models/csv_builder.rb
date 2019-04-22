class CsvBuilder < ProductDataBuilder
  def build(csv_row)
    data = csv_row.to_h.symbolize_keys
    formatter.format(data)
  end
end
