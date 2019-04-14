require "rails_helper"

RSpec.describe "user deletes a product spec" do
  scenario "by clicking the delete button on the products show_page" do
    product = create(:product)

    visit product_path(product)
    click_on "Delete"

    expect(Product.count).to eq(0)
  end
end
