class GraphqlMocksController < ApplicationController
  def imitate
    render json: { "data" => { "query" => params[:query], "say" => "Here we'll send Mock API response!" } }    
  end 
end