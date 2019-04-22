class FileImporter
  attr_reader :filepath, :builder

  def initialize(filepath, builder)
    @filepath = filepath
    @builder = builder
  end

  def import
    raise "Must overwrite method"
  end
end
