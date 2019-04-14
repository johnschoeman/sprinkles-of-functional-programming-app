require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe ".import" do
    context "the file is a csv" do
      it "saves every row in the file as new product" do
        require "csv"
        file =
          CSV.generate do |csv|
            csv << %w[name author release_date version value active]
            csv << %w[name_a author_a 20190101 1.0 1 true]
            csv << %w[name_b author_b 20190201 1.1 2 false]
            csv << %w[name_c author_c 20190301 1.2 3 true]
          end
        filename = "test.csv"
        allow(File).to receive(:open).with(
                   filename,
                   "r",
                   { headers: true, universal_newline: false },
                 )
                   .and_return(file)

        Product.import(filename)

        expect(Product.count).to eq 3
      end
    end
  end
end
