require "rails_helper"

RSpec.describe ProductDataImporter, type: :model do
  describe "#import" do
    context "the file is a csv" do
      it "imports the file using a CsvImporter" do
        filename = "products.csv"
        formatter = ProductDataFormatter.new
        importer = ProductDataImporter.new(filename, formatter)
        csv_importer_double = double("CsvImporter")
        allow(csv_importer_double).to receive(:import)
        allow(CsvImporter).to receive(:new).and_return(csv_importer_double)

        importer.import

        expect(CsvImporter).to have_received(:new)
      end
    end

    context "the file is a xlsx" do
      it "saves every row in the file as new product" do
        filename = "products.xlsx"
        formatter = ProductDataFormatter.new
        importer = ProductDataImporter.new(filename, formatter)
        xlsx_importer_double = double("XlsxImporter")
        allow(xlsx_importer_double).to receive(:import)
        allow(XlsxImporter).to receive(:new).and_return(xlsx_importer_double)

        importer.import

        expect(XlsxImporter).to have_received(:new)
      end
    end

    context "the file is an unknown format" do
      it "raises" do
        filename = "products.unknown"
        formatter = ProductDataFormatter.new
        importer = ProductDataImporter.new(filename, formatter)

        expect { importer.import }.to raise_error("Unknown file type")
      end
    end
  end
end
