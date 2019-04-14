require "rails_helper"

RSpec.describe "products/new.html.erb" do
  it "renders a form for creating a new product" do
    product = Product.new

    render template: "products/new.html.erb", locals: { product: product }

    expect(rendered).to have_content("New Product Form")
  end
end
