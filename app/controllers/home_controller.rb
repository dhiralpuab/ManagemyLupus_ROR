class HomeController < ApplicationController
  def index
  end

  def lupus_info
    @gender = params[:gender]
    @status = params[:status]
  end
end
