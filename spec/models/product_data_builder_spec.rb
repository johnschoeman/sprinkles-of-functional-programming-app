require "rails_helper"

RSpec.describe ProductDataBuilder, type: :model do
  describe "#build" do
    it "raises" do
      formatter = double
      builder = ProductDataBuilder.new(formatter)

      expect { builder.build }.to raise_error("Must override method")
    end
  end
end
