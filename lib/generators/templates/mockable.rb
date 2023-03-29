# frozen_string_literal: true

module Mockable
  private

  def bypass_graphql
    redirect_to(imitate_path(query: params[:query]))
  end
end