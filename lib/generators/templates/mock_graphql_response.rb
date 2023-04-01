class MockGraphqlResponse < ApplicationRecord
  enum req_type: [:query, :mutation]
  
  # All output modes except :void map to the OpenAI response attribute 'finish_reason' to determine model output
  enum output_mode: [:void, :token_limit, :content_filter, :incomplete, :stop]  
end