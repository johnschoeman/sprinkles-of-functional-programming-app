class ProductDataBuilder
  attr_reader :formatter

  def initialize(formatter)
    @formatter = formatter
  end

  def build
    raise "Must override method"
  end
end
