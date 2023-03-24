# frozen_string_literal: true

require 'json'
require 'httparty'

module OpenAiGateway
  def get_open_ai_completion(prompt, model = 'gpt-3.5-turbo')
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"
    }

    data = {
      model: model,
      temperature: 0.2,
      messages: [{
        role: 'user',
        content: prompt
      }]
    }

    response = HTTParty.post('https://api.openai.com/v1/chat/completions', headers: headers, body: data.to_json)
    response.body
  end
end
