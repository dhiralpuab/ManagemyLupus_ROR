class SurveyController < ApplicationController
  include SurveyHelper
  
  def save
    session[:survey] = {
      gender: params[:gender],
      status: params[:status],
      kidney_treatment: params[:kidney_treatment],
      notes: params[:notes]
    }
    
    redirect_to survey_next_path(category: "basic")
  end

  def next
    @learn_more_cards = SurveyCard.learn_cards
    @survey_data = session[:survey]

    # User's selected tags
    user_gender = @survey_data["gender"]&.to_sym
    user_status = @survey_data["status"]&.to_sym
    user_kidney = @survey_data["kidney_treatment"]&.to_sym
    user_concerns = @survey_data["notes"]&.to_sym
    tab_category = (params[:category] || "basic").to_sym

    if @survey_data["notes"].present?
      notes_text = @survey_data["notes"]
      user_embedding = SurveyHelper.get_embedding(notes_text)

      Rails.logger.info "User notes: #{notes_text}"
      Rails.logger.info "User embedding first 10 values: #{user_embedding[0..9].join(', ')}"
    end




    # Pick card set based on tab
    card_set = case tab_category
              when :basic then SurveyCard.intro
              when :treatment then SurveyCard.treatment
              when :steroids then SurveyCard.steroids
              when :biologic then SurveyCard.biologic
              when :sexspissues then SurveyCard.sexspissues
              when :foryou then SurveyCard.treatment + SurveyCard.steroids + SurveyCard.biologic + SurveyCard.sexspissues
              else SurveyCard.intro
              end

    @cards = filter_cards(card_set, user_gender, user_status, user_kidney)

    if tab_category == :foryou && user_embedding
      @cards = rank_cards_by_notes(@cards, user_embedding)
    end

  end

  private

  def filter_cards(card_set, user_gender, user_status, user_kidney)
    gender_tags = [:male, :female]
    status_tags = [:quiet, :active_no_kidneys, :active_kidneys]
    kidney_tags = [:a, :b, :c, :d]

    card_set.select do |card|
      card_cats = card.categories.map(&:to_sym)

      # Gender filter
      if (card_cats & gender_tags).any? && !(card_cats & gender_tags).include?(user_gender)
        next false
      end

      # Status filter
      if (card_cats & status_tags).any? && !(card_cats & status_tags).include?(user_status)
        next false
      end

      # Kidney filter
      if (card_cats & kidney_tags).any? && !(card_cats & kidney_tags).include?(user_kidney)
        next false
      end

      true
    end
  end

  def rank_cards_by_notes(cards, user_embedding)
    cards
      .map do |card|
        next unless card.description.present?
        card_vector = SurveyHelper.get_embedding(card.description)
        [card, cosine_similarity(user_embedding, card_vector)]
      end
      .compact
      .sort_by { |_, score| -score }
      .first(10)
      .map(&:first)
  end


  def cosine_similarity(vec1, vec2)
    dot = vec1.zip(vec2).map { |a,b| a*b }.sum
    mag1 = Math.sqrt(vec1.map { |x| x**2 }.sum)
    mag2 = Math.sqrt(vec2.map { |x| x**2 }.sum)
    dot / (mag1 * mag2)
  end



end
