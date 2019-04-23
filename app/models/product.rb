require "csv"

class Product < ApplicationRecord
  validates :name, presence: true
end
