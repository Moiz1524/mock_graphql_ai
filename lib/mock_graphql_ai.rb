require 'mock_graphql_ai/version'
require 'openai'
require 'graphql'

module MockGraphqlAi
  class Resource
    attr_accessor :query, :type, :name, :client, :openai_access_token, :response

    def initialize(options={})
      @query = options[:query]
      @openai_access_token = options[:token]
      @temperature = 0.3
      @model = "gpt-3.5-turbo"
    end
  
    def respond!
      @type, @name = grab_query_details
      initiate_openai_client
      get_response_from_ai
    end

    private
      
      def grab_query_details
        query_definition = GraphQL.parse(query).definitions[0]
        [query_definition.operation_type, query_definition.selections[0].name]
      end

      def initiate_openai_client
        @client = OpenAI::Client.new(access_token: openai_access_token)        
      end

      def get_response_from_ai
        return mock_response.data if mock_response
        
        @response = client.chat(
          parameters: {
            model: @model,
            temperature: @temperature,
            messages: [
              { role: "system", content: instructions_to_model },
              { role: "user", content: "#{query}" }
            ],
            max_tokens: 1000
          }
        )

        persist_response! if complete_model_output?
        response.dig("choices", 0, "message", "content")
      end

      def mock_response
        MockGraphqlResponse.find_by(name: name, req_type: type)
      end

      def instructions_to_model
        "You are a helpful coding assistant. Below are the points you must consider while helping me
  
        - I will give you a GraphQL query or mutation
        - You have to return me the only response back
        - Don't append any conversational or explanation text around it
        - Don't give me code implementations you used to achieve this response
        - Use double quotes around key value pairs
        - Give me data objects to consume within
        - I want real data instead of empty collection back to consume within my React Frontend app
        - Avoid errors because I have to parse data back to JSON"
      end

      def persist_response!
        MockGraphqlResponse.create(
          data: @response.dig("choices", 0, "message", "content"),
          name: name,
          req_type: type,
          output_mode: figure_output_mode 
        )
      end
      
      def complete_model_output?
        @response.dig("choices", 0, "finish_reason") == "stop"
      end

      def figure_output_mode
        finish_reason = response.dig("choices", 0, "finish_reason")

        reasons_mapper = {
          "length" => :token_limit,
          "content_filter" => :content_filter,
          "null" => :incomplete,
          "stop" => :stop 
        }

        reasons_mapper[finish_reason]
      end
  end
end