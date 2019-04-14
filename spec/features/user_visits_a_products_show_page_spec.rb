require "rails_helper"

RSpec.describe "user visits a products show page" do
  scenario "by clicking the products link on the products index" do
    product = create(:product)

    visit products_path

    click_on "Show"

    expect(page).to have_content(product.name)
  end
end
