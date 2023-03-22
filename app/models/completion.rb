class Completion
  include OpenAiGateway
  def get_completion(prompt)
    response = get_open_ai_completion(prompt)

    content = parse_content(response)
    code = parse_code(content)
    info = parse_info(content)

    { code: code, info: info }
  end

  def parse_content(response)
    JSON.parse(response)['choices'].first['message']['content']
  end

  def parse_code(content)
    content.scan(/```(.+?)```/m)[0][0]
  end

  def parse_info(content)
    content.scan(/\n(.+?)```/m)[0][0]
  end
end