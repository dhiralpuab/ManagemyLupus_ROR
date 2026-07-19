# frozen_string_literal: true

class CardsController < ApplicationController
  def show
    @card_id = params[:id].to_i
    @card = find_card(@card_id)

    if @card.nil?
      head :not_found
      return
    end

    if turbo_native_app?
      render layout: "turbo_native"
    else
      render layout: "application"
    end
  end

  private

  def find_card(id)
    all_cards = SurveyCard.intro +
                SurveyCard.treatment +
                SurveyCard.steroids +
                SurveyCard.biologic +
                SurveyCard.sexspissues +
                SurveyCard.learn_cards

    all_cards.find { |c| c.id == id }
  end
end
