require "rails_helper"

RSpec.describe "user edits a product spec" do
  scenario "by clicking the edit link on the products index" do
    product = create(:product)
    new_name = Faker::App.name
    new_version = Faker::App.version
    new_value = Faker::Number.number(5).to_i
    new_author = Faker::Name.name

    visit products_path

    click_on "Edit"
    expect(page).to have_content("Edit Product")

    fill_in "Name", with: new_name
    fill_in "Version", with: new_version
    fill_in "Value", with: new_value
    fill_in "Author", with: new_author

    click_on "Update Product"

    product = Product.last
    expect(product.name).to eq(new_name)
    expect(product.version).to eq(new_version)
    expect(product.value).to eq(new_value)
    expect(product.author).to eq(new_author)

    expect(page).to have_content("Products Index")
  end
end
