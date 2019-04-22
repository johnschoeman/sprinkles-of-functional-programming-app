require "rails_helper"

RSpec.describe XlsxBuilder, type: :model do
  describe "#build" do
    context "when given a csv_row of product data" do
      it "creates a hash of the product data" do
        name = "name"
        author = "author"
        version = "1.10.3"
        release_date = "20190101"
        value = "100"
        active = "true"

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
        formatter = ProductDataFormatter.new
        builder = XlsxBuilder.new(formatter)

        result = builder.build(xlsx_row)

        expect(result).to eq(
                    {
                      name: "name",
                      author: "author",
                      version: "1.10.3",
                      release_date: Time.zone.parse("20190101"),
                      value: 100,
                      active: true,
                    },
                  )
      end
    end
  end

  def build_cell(row, column, value)
    cell = RubyXL::Cell.new
    cell.row = row
    cell.column = column
    allow(cell).to receive(:value).and_return(value)
    cell
  end
end
