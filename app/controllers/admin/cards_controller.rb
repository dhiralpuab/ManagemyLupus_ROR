# frozen_string_literal: true

module Admin
  class CardsController < ApplicationController
    # Hardcoded credentials - change these!
    ADMIN_USERNAME = "admin"
    ADMIN_PASSWORD = "lupus2024"

    before_action :block_native_apps
    before_action :authenticate, except: [:login, :do_login]
    before_action :set_card, only: [:edit, :update]
    layout "admin"

    def index
      @categories = {
        intro: SurveyCard.intro,
        treatment: SurveyCard.treatment,
        steroids: SurveyCard.steroids,
        biologic: SurveyCard.biologic,
        sexspissues: SurveyCard.sexspissues,
        learn_cards: SurveyCard.learn_cards
      }
    end

    def login
      # Show login form
      render layout: false
    end

    def do_login
      if params[:username] == ADMIN_USERNAME && params[:password] == ADMIN_PASSWORD
        session[:admin_authenticated] = true
        redirect_to admin_cards_path, notice: "Logged in successfully."
      else
        redirect_to login_admin_cards_path, alert: "Invalid username or password."
      end
    end

    def logout
      session.delete(:admin_authenticated)
      redirect_to root_path, notice: "Logged out successfully."
    end

    def new
      @category = params[:category]&.to_sym
      @card = nil
    end

    def create
      category = params[:category]&.to_sym
      cards = load_cards_for_category(category)

      # Generate new ID (max ID in this category + 1)
      max_id = cards.map { |c| c[:id] }.max || 0
      new_id = max_id + 1

      new_card = {
        id: new_id,
        title: params[:title],
        image_url: params[:image_url],
        description: parse_description(params[:description]),
        categories: parse_categories(params[:categories]),
        learn_more: params[:learn_more].presence,
        learn_more_id: params[:learn_more_id].presence&.to_i,
        hidden: params[:hidden] == "1"
      }

      cards << new_card
      save_cards_version(category, cards)

      redirect_to admin_cards_path, notice: "Card ##{new_id} created successfully!"
    end

    def edit
    end

    def update
      # Load current cards for this category
      cards = load_cards_for_category(@category)

      # Find and update the specific card
      card_index = cards.find_index { |c| c[:id] == @card_id }

      if card_index
        cards[card_index] = {
          id: @card_id,
          title: params[:title],
          image_url: params[:image_url],
          description: parse_description(params[:description]),
          categories: parse_categories(params[:categories]),
          learn_more: params[:learn_more].presence,
          learn_more_id: params[:learn_more_id].presence&.to_i,
          hidden: params[:hidden] == "1"
        }

        # Save new version
        save_cards_version(@category, cards)

        redirect_to admin_cards_path, notice: "Card updated successfully! Version saved."
      else
        redirect_to admin_cards_path, alert: "Card not found."
      end
    end

    def history
      @category = params[:category]&.to_sym
      @versions = CardVersionService.list_versions(@category)
    end

    def preview_version
      @category = params[:category]&.to_sym
      @version = params[:version]
      @cards = CardVersionService.load_version(@category, @version)

      # Find the previous version to compare against
      versions = CardVersionService.list_versions(@category)
      current_index = versions.index(@version)

      if current_index && current_index < versions.length - 1
        @previous_version = versions[current_index + 1]
        previous_cards = CardVersionService.load_version(@category, @previous_version)
        @changes = calculate_changes(@cards, previous_cards)
      else
        @previous_version = nil
        @changes = { added: [], removed: [], modified: [] }
      end
    end

    def restore_version
      category = params[:category]&.to_sym
      version = params[:version]

      if version == "original"
        cards = CardVersionService.load_original(category)
      else
        cards = CardVersionService.load_version(category, version)
      end

      if cards
        CardVersionService.save(category, cards)
        redirect_to admin_cards_path, notice: "Version restored successfully! (Original data has been saved as a new version)"
      else
        redirect_to admin_cards_path, alert: "Could not restore version."
      end
    end

    def delete_version
      category = params[:category]&.to_sym
      version = params[:version]

      if version == "original"
        redirect_to history_admin_cards_path(category: category), alert: "Cannot delete the original version."
        return
      end

      if CardVersionService.delete_version(category, version)
        redirect_to history_admin_cards_path(category: category), notice: "Version deleted successfully."
      else
        redirect_to history_admin_cards_path(category: category), alert: "Could not delete version."
      end
    end

    def destroy
      category = params[:category]&.to_sym
      card_id = params[:id].to_i

      cards = load_cards_for_category(category)
      original_count = cards.count

      # Remove the card
      cards.reject! { |c| c[:id] == card_id }

      if cards.count < original_count
        save_cards_version(category, cards)
        redirect_to admin_cards_path, notice: "Card ##{card_id} deleted successfully."
      else
        redirect_to admin_cards_path, alert: "Card not found."
      end
    end

    private

    def block_native_apps
      if turbo_native_app?
        redirect_to root_path, alert: "Admin panel is not available in the app."
      end
    end

    def authenticate
      unless session[:admin_authenticated]
        redirect_to login_admin_cards_path
      end
    end

    def set_card
      @category = params[:category]&.to_sym
      @card_id = params[:id].to_i

      cards = case @category
              when :intro then SurveyCard.intro
              when :treatment then SurveyCard.treatment
              when :steroids then SurveyCard.steroids
              when :biologic then SurveyCard.biologic
              when :sexspissues then SurveyCard.sexspissues
              when :learn_cards then SurveyCard.learn_cards
              else []
              end

      @card = cards.find { |c| c.id == @card_id }
      redirect_to admin_cards_path, alert: "Card not found" unless @card
    end

    def load_cards_for_category(category)
      cards = case category
              when :intro then SurveyCard.intro
              when :treatment then SurveyCard.treatment
              when :steroids then SurveyCard.steroids
              when :biologic then SurveyCard.biologic
              when :sexspissues then SurveyCard.sexspissues
              when :learn_cards then SurveyCard.learn_cards
              else []
              end

      cards.map do |card|
        {
          id: card.id,
          title: card.title,
          image_url: card.image_url,
          description: card.description,
          categories: card.categories,
          learn_more: card.learn_more,
          learn_more_id: card.learn_more_id,
          hidden: card.hidden?
        }
      end
    end

    def save_cards_version(category, cards)
      CardVersionService.save(category, cards)
    end

    def calculate_changes(current_cards, previous_cards)
      return { added: [], removed: [], modified: [] } unless current_cards && previous_cards

      current_by_id = current_cards.index_by { |c| c[:id] }
      previous_by_id = previous_cards.index_by { |c| c[:id] }

      added = []
      removed = []
      modified = []

      # Find added and modified cards
      current_by_id.each do |id, card|
        if previous_by_id[id].nil?
          added << card
        else
          changes = get_field_changes(card, previous_by_id[id])
          if changes.any?
            modified << { card: card, changes: changes }
          end
        end
      end

      # Find removed cards
      previous_by_id.each do |id, card|
        removed << card if current_by_id[id].nil?
      end

      { added: added, removed: removed, modified: modified }
    end

    def get_field_changes(current, previous)
      changes = []

      # Normalize and compare title
      cur_title = current[:title].to_s.strip
      prev_title = previous[:title].to_s.strip
      if cur_title != prev_title
        changes << { field: "Title", from: prev_title, to: cur_title }
      end

      # Normalize and compare image
      cur_img = current[:image_url].to_s.strip
      prev_img = previous[:image_url].to_s.strip
      if cur_img != prev_img
        changes << { field: "Image", from: prev_img, to: cur_img }
      end

      # Compare description - find what actually changed
      cur_desc = Array(current[:description]).map { |d| d.to_s.strip }.reject(&:empty?)
      prev_desc = Array(previous[:description]).map { |d| d.to_s.strip }.reject(&:empty?)

      if cur_desc != prev_desc
        # Find which specific lines changed
        changed_lines = []
        max_len = [cur_desc.length, prev_desc.length].max

        max_len.times do |i|
          old_line = prev_desc[i]&.strip
          new_line = cur_desc[i]&.strip

          if old_line != new_line
            changed_lines << { old: old_line, new: new_line, index: i + 1 }
          end
        end

        changes << { field: "Description", changed_lines: changed_lines } if changed_lines.any?
      end

      # Normalize categories (convert to strings and sort)
      cur_cats = Array(current[:categories]).map(&:to_s).sort
      prev_cats = Array(previous[:categories]).map(&:to_s).sort
      if cur_cats != prev_cats
        changes << { field: "Categories", from: prev_cats.join(", "), to: cur_cats.join(", ") }
      end

      # Compare learn_more text
      cur_lm = current[:learn_more].to_s.strip
      prev_lm = previous[:learn_more].to_s.strip
      if cur_lm != prev_lm
        changes << { field: "Learn More Text", from: prev_lm.presence || "(none)", to: cur_lm.presence || "(none)" }
      end

      # Compare learn_more_id
      cur_lm_id = current[:learn_more_id].to_i
      prev_lm_id = previous[:learn_more_id].to_i
      if cur_lm_id != prev_lm_id
        changes << { field: "Learn More Link", from: prev_lm_id == 0 ? "(none)" : "##{prev_lm_id}", to: cur_lm_id == 0 ? "(none)" : "##{cur_lm_id}" }
      end

      # Compare hidden status
      cur_hidden = current[:hidden] == true
      prev_hidden = previous[:hidden] == true
      if cur_hidden != prev_hidden
        changes << { field: "Hidden", from: prev_hidden ? "Yes" : "No", to: cur_hidden ? "Yes" : "No" }
      end

      changes
    end

    def parse_description(desc)
      return [] if desc.blank?
      desc.split("\n").map(&:strip).reject(&:blank?)
    end

    def parse_categories(cats)
      return [] if cats.blank?
      # Handle both array (from checkboxes) and string (legacy) formats
      if cats.is_a?(Array)
        cats.map(&:to_sym).reject { |c| c.blank? }
      else
        cats.split(",").map(&:strip).map(&:to_sym).reject { |c| c.blank? }
      end
    end
  end
end
