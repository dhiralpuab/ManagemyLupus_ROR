# frozen_string_literal: true

module TurboNativeNavigation
  extend ActiveSupport::Concern

  included do
    helper_method :turbo_native_app?
    helper_method :turbo_native_ios?
    helper_method :turbo_native_android?
  end

  private

  def turbo_native_app?
    request.user_agent.to_s.include?("Turbo Native")
  end

  def turbo_native_ios?
    turbo_native_app? && request.user_agent.to_s.include?("iOS")
  end

  def turbo_native_android?
    turbo_native_app? && request.user_agent.to_s.include?("Android")
  end

  def set_turbo_native_variant
    request.variant = :native if turbo_native_app?
  end
end
