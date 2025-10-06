module SurveyHelper
  def self.get_embedding(text)
    text = text.to_s.strip
    raise "Empty text for embedding" if text.empty?
    response = OpenAIClient.embeddings(
      parameters: {
        model: "text-embedding-3-small",
        input: text
      }
    )
    response.dig("data", 0, "embedding")
  end
end
