require "rails_helper"

RSpec.describe "products/edit.html.erb" do
  it "renders a form for editing a product" do
    product = build_stubbed(:product)

    render template: "products/edit.html.erb", locals: { product: product }

    expect(rendered).to have_content("Edit Product Form")
  end
end
