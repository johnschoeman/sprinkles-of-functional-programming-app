require "rails_helper"

RSpec.describe CsvImporter, type: :model do
  describe "#import" do
    it "saves every row in the file as new product" do
      filename = "products.csv"
      stub_csv(filename)
      formatter = ProductDataFormatter.new
      importer = CsvImporter.new(filename, formatter)

      importer.import

      expect(Product.count).to eq 3
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
end
