require "rails_helper"

RSpec.describe "User uploads a file of produce data" do
  context "and the file is a csv" do
    scenario "by visiting the root page and clicking 'upload file'" do
      visit root_path

      attach_file("file", Rails.root.join("spec/fixtures/products.csv"))
      click_on "Upload File"

      expect(Product.count).to eq 3
    end
  end

  context "and the file is a xslx" do
    scenario "the user uploads via an upload button on the index page" do
      visit root_path
      attach_file("file", Rails.root.join("spec/fixtures/products.xlsx"))
      click_on "Upload File"

      expect(Product.count).to eq 3
    end
  end
end
