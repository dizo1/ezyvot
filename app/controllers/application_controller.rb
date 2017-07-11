class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_timezone 

    def set_timezone  
        min = request.cookies["time_zone"].to_i
        Time.zone = ActiveSupport::TimeZone[-min.minutes]
    end 

  
end
