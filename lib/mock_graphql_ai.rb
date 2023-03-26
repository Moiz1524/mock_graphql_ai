require 'mock_graphql_ai/version'

module MockGraphqlAi
  def self.add_mock_result_assignment(controller_file_path)
    file_contents = File.read(controller_file_path)
    modified_contents = file_contents.gsub(
      /(result\s*=\s*)GraphqlBoilerplateSchema\.execute\(query, variables: variables, context: @context, operation_name: operation_name\)/m,
      "result = ENV['GRAPHQL_MOCK_MODE'] ? Mocks::Resource.new({ query: query }).call : \\0"
    )

    File.write(controller_file_path, modified_contents)
  end
end