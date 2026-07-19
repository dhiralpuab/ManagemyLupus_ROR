# frozen_string_literal: true

module Turbo
  class NativeController < ApplicationController
    skip_before_action :verify_authenticity_token

    def configuration
      render json: {
        settings: {
          tabs: [
            { title: "Home", path: "/" },
            { title: "Survey", path: "/survey/next?category=basic" }
          ]
        },
        rules: [
          {
            patterns: ["^/$"],
            properties: {
              presentation: "replace",
              context: "default"
            }
          },
          {
            patterns: ["^/survey/next"],
            properties: {
              presentation: "push",
              context: "default",
              pull_to_refresh_enabled: true
            }
          },
          {
            patterns: ["^/survey/save$"],
            properties: {
              presentation: "none"
            }
          },
          {
            patterns: ["^/cards/\\d+$"],
            properties: {
              presentation: "modal",
              context: "modal"
            }
          }
        ]
      }
    end
  end
end
