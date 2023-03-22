require 'rails_helper'

describe CompletionsController do
  describe 'GET #ask' do
    let(:query) { 'how to write hello world in ruby' }
    it 'should return status code 200' do
      get :ask, params: { query: query }, as: :json
      expect(response.status).to eql(200)
    end

    it 'response should contain code' do
      get :ask, params: { query: query }, as: :json
      expect(JSON.parse(response.body)['code']).to have_attributes(size: (be > 0))
    end

    it 'response should contain info' do
      get :ask, params: { query: query }, as: :json
      expect(JSON.parse(response.body)['info']).to have_attributes(size: (be > 0))
    end

    it 'should call completions method of completion' do
      service = instance_double(Completion)
      allow(service).to receive(:get_completion)
    end
  end
end
