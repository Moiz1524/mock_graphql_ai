require 'rails/generators'

module MockGraphqlAi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

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

      def copy_migration
        migration_template(
          'migration.rb', 
          'db/migrate/create_mock_graphql_responses.rb', 
          migration_version: migration_version
        )
      end

      def register_controller_main_route
        route "get '/imitate_graphql', to: 'graphql_mocks#imitate', as: :imitate_graphql"
      end

      private

      def self.next_migration_number(dirname)
        Time.now.utc.strftime('%Y%m%d%H%M%S')
      end      
      
      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
  end
end