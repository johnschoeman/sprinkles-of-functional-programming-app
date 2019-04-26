require "csv"

class ProductDataImporter
  def self.import(filepath)
    new.import(filepath)
  end

  def import(filepath)
    read_file(filepath).
      map { |row| process_data(row) }.
      map { |data| Product.create(data) }
  end

  private

  def read_file(filepath)
    results = []
    CSV.foreach(filepath, headers: true) do |row|
      results << row.to_h.symbolize_keys
    end
    results
  end

  def process_data(data)
    process_active(data).
      then { |data| process_release_date(data) }
  end

  def process_active(data)
    active = data[:active]
    data[:active] = active == "true"
    data
  end

  def process_release_date(data)
    release_date = data[:release_date]
    data[:release_date] = Time.zone.parse(release_date)
    data
  end
end
