# frozen_string_literal: true

module YamlLoadable
  extend ActiveSupport::Concern

  class_methods do
    # Load cards from YAML if available, otherwise use hardcoded
    def load_with_yaml_override(category, &fallback)
      # Check for YAML version first
      yaml_cards = ::CardVersionService.load_latest(category)

      if yaml_cards
        Rails.logger.info "[SurveyCard] Loading #{category} from YAML"
        yaml_cards.map do |card_data|
          new(
            id: card_data[:id],
            title: card_data[:title],
            image_url: card_data[:image_url],
            description: card_data[:description] || [],
            categories: (card_data[:categories] || []).map(&:to_sym),
            learn_more: card_data[:learn_more],
            learn_more_id: card_data[:learn_more_id],
            hidden: card_data[:hidden] || false
          )
        end
      else
        # Use hardcoded fallback
        fallback.call
      end
    end
  end
end
