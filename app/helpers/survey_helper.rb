module SurveyHelper
  require "json"
  require "digest"

  EMBEDDING_DIR = Rails.root.join("tmp", "embeddings")
  MODEL = "text-embedding-3-small"

  def self.get_embedding(text)
    text = text.to_s.strip
    raise ArgumentError, "Empty text for embedding" if text.empty?

    # Normalize text to reduce duplicates
    normalized_text = text.downcase.gsub(/\s+/, " ").strip

    # Ensure directory exists
    FileUtils.mkdir_p(EMBEDDING_DIR)

    # Stable filename
    hash = Digest::SHA256.hexdigest("#{MODEL}:#{normalized_text}")
    path = EMBEDDING_DIR.join("#{hash}.json")

    # Return cached embedding if present
    if File.exist?(path)
      cached = JSON.parse(File.read(path))
      return cached["embedding"]
    end

    # Call OpenAI only if needed
    response = OpenAIClient.embeddings(
      parameters: {
        model: MODEL,
        input: text
      }
    )

    embedding = response.dig("data", 0, "embedding")

    # Save JSON
    File.write(
      path,
      JSON.pretty_generate(
        {
          original_text: text,
          normalized_text: normalized_text,
          model: MODEL,
          embedding: embedding,
          created_at: Time.current
        }
      )
    )

    embedding
  end
end
