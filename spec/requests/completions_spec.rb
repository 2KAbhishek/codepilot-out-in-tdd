require 'rails_helper'

RSpec.describe "Completions", type: :request do
  describe "GET /ask" do
    it "returns http success" do
      get "/completions/ask"
      expect(response).to have_http_status(:success)
    end
  end

end
