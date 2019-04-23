require "rails_helper"
require "csv"

RSpec.describe ProductDataImporter do
  describe ".import" do
    context "when provided a csv file" do
      it "creates product data from the data" do
        filename = Rails.root.join("spec/fixtures/products.csv")
        importer = ProductDataImporter.new

        importer.import(filename)

        expect(Product.count).to eq 3
        last_product = Product.last
        expect_product_to_match(
          last_product,
          "name_c",
          "author_c",
          Time.zone.parse("20190302"),
          3000,
          "0.53",
          true,
        )
      end
    end

    context "when provided a xlsx file" do
      it "creates product data from the data" do
        filename = Rails.root.join("spec/fixtures/products.xlsx")
        importer = ProductDataImporter.new

        importer.import(filename)

        expect(Product.count).to eq 4
        last_product = Product.last
        expect_product_to_match(
          last_product,
          "factory_bot",
          "thoughtbot",
          DateTime.new(2008, 5, 28),
          9001,
          "5.0.2",
          true,
        )
      end
    end
  end

  def expect_product_to_match(
    product, name, author, release_date, value, version, active
  )
    expect(product.name).to eq(name)
    expect(product.author).to eq(author)
    expect(product.release_date).to eq(release_date)
    expect(product.value).to eq(value)
    expect(product.version).to eq(version)
    expect(product.active).to eq(active)
  end
end
