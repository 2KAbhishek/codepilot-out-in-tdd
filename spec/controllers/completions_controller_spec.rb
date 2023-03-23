require 'rails_helper'
require 'webmock'
include WebMock::API

describe CompletionsController do
  describe 'GET #ask' do
    WebMock.enable!
    before :each do
      stub_request(:post, 'https://api.openai.com/v1/chat/completions')
        .with(
          body: '{"model":"gpt-3.5-turbo","temperature":0.2,"messages":[{"role":"user","content":"how to write hello world in ruby"}]}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}",
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: mock_response, headers: {})
    end

    let(:mock_response) do
      "{\"id\":\"chatcmpl-6wz0dMspx8QiyGpGIgDpzXowivbas\",
      \"object\":\"chat.completion\",
      \"created\":1679515563,
      \"model\":\"gpt-3.5-turbo-0301\",
      \"usage\":{\"prompt_tokens\":14,
      \"completion_tokens\":44,
      \"total_tokens\":58},
      \"choices\":[{\"message\":{\"role\":\"assistant\",
      \"content\":\"\\n\\nIn Ruby you can use the following code:\\n\\n```ruby\\nputs \\\"Hello, World!\\\"\\n```\\n\\n\"},
      \"finish_reason\":\"stop\",
      \"index\":0}]}\n"
    end

    let(:query) { 'how to write hello world in ruby' }

    it 'response should contain proper response' do
      get :ask, params: { query: query }, as: :json
      expect(response.status).to eql(200)
      expect(JSON.parse(response.body)['code']).to have_attributes(size: (be > 0))
      expect(JSON.parse(response.body)['info']).to have_attributes(size: (be > 0))
    end

    it 'should call completions method of completion' do
      service = instance_double(Completion)
      allow(service).to receive(:get_completion)
    end
  end
end
