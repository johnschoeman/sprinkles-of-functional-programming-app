require "rails_helper"

RSpec.describe ProductDataFormatter, type: :model do
  describe "#build" do
    it "builds a data hash from a csv_row for the product" do
      headers = %w[name author version release_date value active]
      fields = %w[name_a author_a 1.10.3 20190101 100 true]
      csv_row = CSV::Row.new(headers, fields)
      formatter = ProductDataFormatter.new

      result = formatter.build(csv_row)

      expect(result).to eq(
                  {
                    name: "name_a",
                    author: "author_a",
                    version: "1.10.3",
                    release_date: Time.zone.parse("20190101"),
                    value: 100,
                    active: true,
                  },
                )
    end
  end
end
