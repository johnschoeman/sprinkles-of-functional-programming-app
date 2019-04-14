require "csv"

class Product < ApplicationRecord
  validates :name, presence: true

  def self.import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      data = row.to_h
      data["active"] = data["active"] == "true"
      data["release_date"] = Time.zone.parse(data["release_date"])
      product = new(data)
      product.save
    end
  end
end
