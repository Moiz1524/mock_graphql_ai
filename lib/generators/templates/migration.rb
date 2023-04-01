class CreateMockGraphqlResponses < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :mock_graphql_responses do |t|
      t.string :name
      t.integer :req_type, null: false, default: 0
      t.integer :output_mode, null: false, default: 0
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end

