require "rails_helper"

RSpec.describe "user deletes a product spec" do
  scenario "by clicking the delete button on the products index" do
    create(:product)

    visit products_path

    click_on "Delete"

    expect(Product.count).to eq(0)
  end
end
