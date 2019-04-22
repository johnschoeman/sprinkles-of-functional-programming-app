require "rails_helper"

RSpec.describe FileImporter, type: :model do
  describe "#import" do
    it "raise if called" do
      importer = FileImporter.new("filepath", double("formatter"))

      expect { importer.import }.to raise_error("Must overwrite method")
    end
  end
end
