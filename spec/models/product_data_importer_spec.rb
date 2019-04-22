require "rails_helper"

RSpec.describe ProductDataImporter, type: :model do
  describe "#import" do
    context "the file is a csv" do
      it "saves every row in the file as new product" do
        filename = "products.csv"
        stub_csv(filename)
        formatter = ProductDataFormatter.new
        importer = ProductDataImporter.new(filename, formatter)

        importer.import

        expect(Product.count).to eq 3
      end
    end

    context "the file is a xlsx" do
      it "saves every row in the file as new product" do
        filename = "products.xlsx"
        stub_xlsx(filename)

        formatter = ProductDataFormatter.new
        importer = ProductDataImporter.new(filename, formatter)

        importer.import

        expect(Product.count).to eq 3
      end
    end
  end

  def stub_csv(filename = "filename.csv")
    file =
      CSV.generate do |csv|
        csv << %w[name author release_date version value active]
        csv << %w[name_a author_a 20190101 1.0 1 true]
        csv << %w[name_b author_b 20190201 1.1 2 false]
        csv << %w[name_c author_c 20190301 1.2 3 true]
      end
    allow(File).to receive(:open).with(
               filename,
               "r",
               { headers: true, universal_newline: false },
             )
               .and_return(file)
  end

  def stub_xlsx(filename = "filename.xlsx")
    workbook = RubyXL::Workbook.new
    workbook.add_worksheet("Sheet 1")
    worksheet = workbook.worksheets.first
    worksheet.add_cell(0, 0, "name")
    worksheet.add_cell(0, 1, "author")
    worksheet.add_cell(0, 2, "release_date")
    worksheet.add_cell(0, 3, "version")
    worksheet.add_cell(0, 4, "value")
    worksheet.add_cell(0, 5, "active")

    build_xlsx_row(worksheet, 1, %w[name_a author_a 20190101 1.0.1 true])
    build_xlsx_row(worksheet, 2, %w[name_b author_b 20190201 1.1.1 true])
    build_xlsx_row(worksheet, 3, %w[name_c author_c 20190301 1.2.1 true])

    allow(RubyXL::Parser).to receive(:parse).with(filename).and_return(workbook)
  end

  def build_xlsx_row(worksheet, row_idx, row_data)
    row_data.each_with_index do |value, col_idx|
      worksheet.add_cell(row_idx, col_idx, value)
    end
  end
end
