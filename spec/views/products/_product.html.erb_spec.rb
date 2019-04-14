require "rails_helper"

RSpec.describe "products/_product.html.erb" do
  it "renders the product information" do
    product = build_stubbed(:product)

    render template: "products/_product.html.erb", locals: { product: product }

    expect(rendered).to have_text(product.name)
    expect(rendered).to have_text(product.author)
    expect(rendered).to have_text(product.version)
    expect(rendered).to have_text(product.date)
    expect(rendered).to have_text(product.value)
  end

  it "renders a delete button" do
    product = build_stubbed(:product)

    render template: "products/_product.html.erb", locals: { product: product }

    expect(rendered).to have_link("Delete")
  end
end
