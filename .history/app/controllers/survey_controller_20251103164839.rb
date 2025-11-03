class SurveyController < ApplicationController
  def save
    session[:survey] = {
      gender: params[:gender],
      status: params[:status],
      kidney_treatment: params[:kidney_treatment]
    }
    Rails.logger.info "OpenAI API Key present? #{ENV['OPENAI_API_KEY'].present?}"
    redirect_to survey_next_path(category: "basic")
  end

  def next
    @learn_more_cards = SurveyCard.learn_cards
    @survey_data = session[:survey]

    # User's selected tags
    user_gender = @survey_data["gender"]&.to_sym
    user_status = @survey_data["status"]&.to_sym
    user_kidney = @survey_data["kidney_treatment"]&.to_sym
    tab_category = (params[:category] || "basic").to_sym

    # Pick card set based on tab
    card_set = case tab_category
              when :basic then SurveyCard.intro
              when :treatment then SurveyCard.treatment
              when :steroids then SurveyCard.steroids
              when :biologic then SurveyCard.biologic
              when :sexspissues then SurveyCard.sexspissues
              else SurveyCard.intro
              end

    @cards = card_set.select do |card|
      card_cats = card.categories

      # 1. For gender filtering - if card has :male or :female, match user gender
      gender_tags = [:male, :female]
      card_gender_tags = card_cats & gender_tags
      if card_gender_tags.any?
        # At least one gender tag on card must match user_gender
        next false unless user_gender && card_gender_tags.include?(user_gender)
      end

      # 2. Status filter - if card has a status tag, it must match user_status
      status_tags = [:quiet, :active_no_kidneys, :active_kidneys] # If your cards use :status with specific sub-tags, adjust accordingly
      card_status_tags = card_cats & status_tags
      if card_status_tags.any?
        next false unless user_status && card_status_tags.include?(user_status)
      end

      # 3. Kidney treatment filter - similarly
      kidney_tags = [:a, :b, :c, :d] # If you have specific kidney sub-tags, replace here
      card_kidney_tags = card_cats & kidney_tags
      if card_kidney_tags.any?
        next false unless user_kidney && card_kidney_tags.include?(user_kidney)
      end

      # Passed all filters
      true
    end
  end

  


end
