# frozen_string_literal: true

class CompletionsController < ApplicationController
  def ask
    query = params[:query]
    api_response = Completion.new.get_completion(query)
    render json: api_response, status: 200
  end
end
