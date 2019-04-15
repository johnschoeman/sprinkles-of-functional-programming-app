require "rails_helper"

RSpec.describe "user visits the product index page" do
  scenario "and they see the list of products" do
    product_one = create(:product)
    product_two = create(:product)

    visit root_path

    expect_page_to_have_product_content(product_one)
    expect_page_to_have_product_content(product_two)
  end

  def expect_page_to_have_product_content(product)
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.author)
    expect(page).to have_content(product.version)
    expect(page).to have_content(product.release_date)
    expect(page).to have_content(product.value)
  end
end
