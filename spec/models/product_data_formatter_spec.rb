require "rails_helper"
require "csv"

RSpec.describe ProductDataFormatter, type: :model do
  describe "#format" do
    it "processes a given hash to be in the correct format" do
      formatter = ProductDataFormatter.new
      data = {
        name: "name",
        author: "author",
        version: "0.0.0",
        release_date: "20190101",
        value: "0",
        active: "true",
      }

      result = formatter.format(data)

      expect(result).to eq(
                  {
                    name: "name",
                    author: "author",
                    version: "0.0.0",
                    release_date: Time.zone.parse("20190101"),
                    value: 0,
                    active: true,
                  },
                )
    end

    context "when the value has a dollar sign" do
      it "strips the dollar sign" do
        formatter = ProductDataFormatter.new
        data = {
          name: "name",
          author: "author",
          version: "0.0.0",
          release_date: "20190101",
          value: "$1230",
          active: "true",
        }

        result = formatter.format(data)

        expect(result).to eq(
                    {
                      name: "name",
                      author: "author",
                      version: "0.0.0",
                      release_date: Time.zone.parse("20190101"),
                      value: 1230,
                      active: true,
                    },
                  )
      end
    end
  end
end
