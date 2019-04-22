class ProductDataFormatter
  def format(data)
    data[:active] = data[:active] == "true"
    data[:release_date] = parse_release_date(data[:release_date])
    data[:value] = parse_value(data[:value])
    data
  end

  private

  def parse_release_date(input)
    if input.is_a?(Float)
      Time.zone.parse(input.to_i.to_s)
    elsif input.is_a?(DateTime)
      input
    else
      Time.zone.parse(input)
    end
  end

  def parse_value(input)
    input.to_s.gsub(/^\$/, "").to_i
  end
end
