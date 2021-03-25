require 'pry'
module ApiHelpers
  def json
    body_parsed = JSON.parse(response.body)
    body_parsed = body_parsed.first if body_parsed.is_a?(Array)
    body_parsed.deep_symbolize_keys
  end

  def json_data
    json[:data]
  end
end
