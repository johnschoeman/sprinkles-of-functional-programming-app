require "factory_bot"
require "faker"

namespace :dev do
  desc "Sample data for local development environment"
  task prime: "db:setup" do
    FactoryBot.create_list(:product, 3)
  end
end
