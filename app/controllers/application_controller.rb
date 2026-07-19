class ApplicationController < ActionController::Base
  include TurboNativeNavigation

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_turbo_native_variant
end
