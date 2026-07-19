# frozen_string_literal: true

class PwaController < ApplicationController
  def offline
    render layout: false
  end
end
