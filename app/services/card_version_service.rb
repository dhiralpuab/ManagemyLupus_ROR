# frozen_string_literal: true

class CardVersionService
  VERSIONS_PATH = Rails.root.join("config", "cards", "versions")
  ORIGINAL_VERSION = "original"

  class << self
    # Load original hardcoded cards
    def load_original(category)
      cards = case category.to_sym
              when :intro then SurveyCard.intro_hardcoded
              when :treatment then SurveyCard.treatment_hardcoded
              when :steroids then SurveyCard.steroids_hardcoded
              when :biologic then SurveyCard.biologic_hardcoded
              when :sexspissues then SurveyCard.sexspissues_hardcoded
              when :learn_cards then SurveyCard.learn_cards_hardcoded
              else []
              end

      cards.map(&:to_h)
    end
    # Save cards with timestamp version
    def save(category, cards)
      ensure_directory_exists

      timestamp = Time.current.strftime("%Y%m%d_%H%M%S")
      filename = "#{category}_#{timestamp}.yml"
      filepath = VERSIONS_PATH.join(filename)

      # Convert to serializable format
      data = {
        "category" => category.to_s,
        "updated_at" => Time.current.iso8601,
        "cards" => cards.map { |card| stringify_keys(card) }
      }

      File.write(filepath, data.to_yaml)
      Rails.logger.info "[CardVersionService] Saved #{filename}"

      # Clear cache so changes take effect
      clear_cache(category)

      filepath
    end

    # Load the latest version for a category
    def load_latest(category)
      filepath = latest_version_path(category)
      return nil unless filepath && File.exist?(filepath)

      load_file(filepath)
    end

    # Load a specific version
    def load_version(category, version)
      # Handle original/hardcoded version
      if version.to_s == ORIGINAL_VERSION
        return load_original(category)
      end

      filepath = VERSIONS_PATH.join("#{category}_#{version}.yml")
      return nil unless File.exist?(filepath)

      load_file(filepath)
    end

    # List all versions for a category (including original)
    def list_versions(category)
      versions = []

      if Dir.exist?(VERSIONS_PATH)
        versions = Dir.glob(VERSIONS_PATH.join("#{category}_*.yml"))
                      .map { |f| File.basename(f, ".yml").sub("#{category}_", "") }
                      .sort
                      .reverse
      end

      # Always add original at the end
      versions << ORIGINAL_VERSION
      versions
    end

    # Get the latest version file path
    def latest_version_path(category)
      return nil unless Dir.exist?(VERSIONS_PATH)

      files = Dir.glob(VERSIONS_PATH.join("#{category}_*.yml")).sort
      files.last
    end

    # Check if YAML versions exist for a category
    def has_versions?(category)
      latest_version_path(category).present?
    end

    # Delete a specific version
    def delete_version(category, version)
      return false if version.to_s == ORIGINAL_VERSION

      filepath = VERSIONS_PATH.join("#{category}_#{version}.yml")
      return false unless File.exist?(filepath)

      File.delete(filepath)
      Rails.logger.info "[CardVersionService] Deleted #{filepath}"
      true
    rescue => e
      Rails.logger.error "[CardVersionService] Error deleting #{filepath}: #{e.message}"
      false
    end

    private

    def ensure_directory_exists
      FileUtils.mkdir_p(VERSIONS_PATH) unless Dir.exist?(VERSIONS_PATH)
    end

    def load_file(filepath)
      data = YAML.load_file(filepath)
      data["cards"].map { |card| symbolize_keys(card) }
    rescue => e
      Rails.logger.error "[CardVersionService] Error loading #{filepath}: #{e.message}"
      nil
    end

    def stringify_keys(hash)
      hash.transform_keys(&:to_s).transform_values do |v|
        case v
        when Hash then stringify_keys(v)
        when Array then v.map { |item| item.is_a?(Hash) ? stringify_keys(item) : item.to_s }
        when Symbol then v.to_s
        else v
        end
      end
    end

    def symbolize_keys(hash)
      hash.transform_keys(&:to_sym).tap do |result|
        result.each do |key, v|
          result[key] = case v
                        when Hash then symbolize_keys(v)
                        when Array
                          v.map do |item|
                            if item.is_a?(Hash)
                              symbolize_keys(item)
                            elsif key == :categories && item.is_a?(String)
                              # Only convert to symbol for the categories array
                              item.to_sym
                            else
                              item
                            end
                          end
                        else v
                        end
        end
      end
    end

    def clear_cache(category)
      # If using Rails cache, clear it here
      Rails.cache.delete("survey_cards_#{category}") if defined?(Rails.cache)
    end
  end
end
