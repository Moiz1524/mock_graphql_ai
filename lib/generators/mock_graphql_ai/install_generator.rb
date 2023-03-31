require 'rails/generators'

module MockGraphqlAi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root(File.expand_path('../templates', __dir__))

      def copy_module_file
        copy_file('mockable.rb', 'app/controllers/concerns/mockable.rb')
      end

      def copy_controller_file
        copy_file('graphql_mocks_controller.rb', 'app/controllers/graphql_mocks_controller.rb')
      end
      
      def copy_model_file
        copy_file('mock_graphql_response.rb', 'app/models/mock_graphql_response.rb')
      end

      def register_controller_main_route
        route "get '/imitate_graphql', to: 'graphql_mocks#imitate', as: :imitate_graphql"
      end
    end
  end
end