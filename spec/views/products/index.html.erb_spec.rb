require "rails_helper"

RSpec.describe "products/index.html.erb" do
  it "renders a list of products" do
    product_one = build(:product)
    product_two = build(:product)
    product_three = build(:product)
    products = [product_one, product_two, product_three]

    render template: "products/index.html.erb", locals: { products: products }

    expect(rendered).to have_text("Products Index")
    expect(rendered).to have_text(product_one.name)
    expect(rendered).to have_text(product_two.name)
    expect(rendered).to have_text(product_three.name)
  end
end
