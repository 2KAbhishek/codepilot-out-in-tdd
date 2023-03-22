require 'rails_helper'

RSpec.describe Completion, type: :model do
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

  let(:mock_content) do
    "\n\nIn Ruby you can use the following code:\n\n```ruby\nputs \"Hello, World!\"\n```\n\n"
  end

  let(:expected_info) { "\nIn Ruby you can use the following code:\n\n" }

  let(:expected_code) { "ruby\nputs \"Hello, World!\"\n" }

  it 'parses response and returns content' do
    expect(subject.parse_content(mock_response)).to eq mock_content
  end

  it 'parses content and returns info' do
    expect(subject.parse_info(mock_content)).to be_truthy
  end

  it 'parses content and returns code' do
    expect(subject.parse_code(mock_content)).to eq expected_code
  end

  it 'calls gateway to fetch completions' do
    gateway = instance_double(OpenAiGateway)
    allow(gateway).to receive(:get_open_ai_completion)
  end
end
