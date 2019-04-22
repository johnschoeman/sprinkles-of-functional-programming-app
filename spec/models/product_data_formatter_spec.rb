require "rails_helper"
require "csv"

RSpec.describe ProductDataFormatter, type: :model do
  describe "#build_csv" do
    it "builds a data hash from a csv_row for the product" do
      headers = %w[name author version release_date value active]
      fields = %w[name_a author_a 1.10.3 20190101 100 true]
      csv_row = CSV::Row.new(headers, fields)
      formatter = ProductDataFormatter.new

      result = formatter.build_csv(csv_row)

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

  describe "#build_xlsx" do
    it "builds a data hash from a xlsx_row for the product" do
      name = "name"
      author = "author"
      version = "1.0.0"
      release_date = "20190101"
      value = "100"
      active = "true"

      xlsx_row = build_row(name, author, version, release_date, value, active)
      formatter = ProductDataFormatter.new

      result = formatter.build_xlsx(xlsx_row)

      expect(result).to eq(
                  {
                    name: "name",
                    author: "author",
                    version: "1.0.0",
                    release_date: Time.zone.parse("20190101"),
                    value: 100,
                    active: true,
                  },
                )
    end
  end

  def build_row(name, author, version, release_date, value, active)
    cell_one = build_cell(1, 0, name)
    cell_two = build_cell(1, 1, author)
    cell_three = build_cell(1, 2, release_date)
    cell_four = build_cell(1, 3, value)
    cell_five = build_cell(1, 4, version)
    cell_six = build_cell(1, 5, active)
    xlsx_row = RubyXL::Row.new
    xlsx_row.cells = [
      cell_one,
      cell_two,
      cell_three,
      cell_four,
      cell_five,
      cell_six,
    ]
    xlsx_row
  end

  def build_cell(row, column, value)
    cell = RubyXL::Cell.new
    cell.row = row
    cell.column = column
    allow(cell).to receive(:value).and_return(value)
    cell
  end
end
