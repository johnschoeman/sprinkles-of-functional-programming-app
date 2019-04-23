require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end
end
