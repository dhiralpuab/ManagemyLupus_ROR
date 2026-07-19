# frozen_string_literal: true

module Admin
  class ImagesController < ApplicationController
    before_action :block_native_apps
    before_action :authenticate
    layout "admin"

    IMAGES_PATH = Rails.root.join("app", "assets", "images")

    def index
      @images = Dir.glob(IMAGES_PATH.join("*.{jpg,jpeg,png,gif,svg}"), File::FNM_CASEFOLD)
                   .map { |f| File.basename(f) }
                   .uniq
                   .sort
    end

    def create
      if params[:image].present?
        uploaded = params[:image]
        filename = sanitize_filename(uploaded.original_filename)
        filepath = IMAGES_PATH.join(filename)

        File.open(filepath, 'wb') do |file|
          file.write(uploaded.read)
        end

        redirect_to admin_images_path, notice: "Image '#{filename}' uploaded successfully!"
      else
        redirect_to admin_images_path, alert: "Please select an image to upload."
      end
    end

    def destroy
      filename = params[:id]
      filepath = IMAGES_PATH.join(filename)

      if File.exist?(filepath) && filepath.to_s.start_with?(IMAGES_PATH.to_s)
        File.delete(filepath)
        redirect_to admin_images_path, notice: "Image '#{filename}' deleted."
      else
        redirect_to admin_images_path, alert: "Image not found."
      end
    end

    def usage
      filename = params[:id]

      # Find all cards using this image
      all_cards = SurveyCard.intro + SurveyCard.treatment + SurveyCard.steroids +
                  SurveyCard.biologic + SurveyCard.sexspissues + SurveyCard.learn_cards

      @using_cards = all_cards.select { |c| c.image_url == filename }
      @filename = filename

      render layout: false
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

    def sanitize_filename(filename)
      filename.gsub(/[^0-9A-Za-z.\-_]/, '_')
    end
  end
end
