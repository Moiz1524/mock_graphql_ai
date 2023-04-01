class GraphqlMocksController < ApplicationController
  def imitate
    result = MockGraphqlAi::Resource.new(
      query: params[:query],
      token: "add-openai-access-token-here" # Rails.application.credentials.dig(:openai, :access_token) 
    ).respond!

    render json: result
  end 
end