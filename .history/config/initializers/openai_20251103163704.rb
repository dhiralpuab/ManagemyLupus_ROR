require "openai"

OpenAIClient = OpenAI::Client.new(
  api_key: ENV.fetch("OPENAI_API_KEY")
)
