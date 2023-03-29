require "rails/generators"

module Generators
  class MockController < Rails::Generators::Base
    source_root(File.expand_path("../generators/templates/controllers", __dir__))

    def copy_controller_file
      copy_file("graphql_mocks_controller.rb", "app/controllers/graphql_mocks_controller.rb")
    end

    def register_controller_main_route
      route "get '/imitate_graphql', to: 'graphql_mocks#imitate', as: :imitate_graphql"
    end
  end
end