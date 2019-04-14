require "rails_helper"

RSpec.describe Product, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
  end

  describe ".import" do
    context "the file is a csv" do
      it "saves every row in the file as new product" do
        require "csv"
        filepath = stub_csv

        Product.import(filepath)

        expect(Product.count).to eq 3
      end
    end
  end

  def stub_csv(filename = "filename.csv")
    file =
      Tempfile.new(filename).tap do |f|
        f.puts "name,author,release_date,version,value,active"
        f.puts "name_a,author_a,20190101,1.0,1,true"
        f.puts "name_b,author_b,20190201,1.1,2,false"
        f.puts "name_c,author_c,20190301,1.2,3,true"
        f.close
      end
    file.path
  end
end
