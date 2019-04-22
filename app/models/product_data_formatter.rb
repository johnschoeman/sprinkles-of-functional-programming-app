class ProductDataFormatter
  def format(data)
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
