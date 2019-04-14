require "rails_helper"

RSpec.describe "user creates a product spec" do
  scenario "by visiting the product index and submiting a new product form" do
    name = Faker::App.name
    date = Date.today
    version = Faker::App.version
    value = Faker::Number.number(5).to_i
    author = Faker::Name.name

    visit products_path

    click_on "Create a New Product"
    fill_in "Name", with: name
    fill_in "Version", with: version
    fill_in "Value", with: value
    fill_in "Author", with: author

    click_on "Create Product"

    expect(Product.count).to eq(1)
    product = Product.last
    expect(product.name).to eq(name)
    expect(product.date).to eq(date)
    expect(product.version).to eq(version)
    expect(product.value).to eq(value)
    expect(product.author).to eq(author)

    expect(page).to have_content "Products Index"
  end
end
