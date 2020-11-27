class DashboardsController < ApplicationController
  def show
    @today_visits = Visit.where(date: Date.today)
    visitref = @today_visits.find { |visit| visit.is_done == false }
    @current_visits = []
    case visitref.position
    when @today_visits.first.position
      @current_visits << visitref
      @current_visits << Visit.find_by(date: Date.today, position: visitref.position + 1)
      @current_visits << Visit.find_by(date: Date.today, position: visitref.position + 2)
    when @today_visits.last.position
      @current_visits << Visit.find_by(date: Date.today, position: visitref.position - 2)
      @current_visits << Visit.find_by(date: Date.today, position: visitref.position - 1)
      @current_visits << visitref
    else
      @current_visits << Visit.find_by(date: Date.today, position: visitref.position - 1)
      @current_visits << visitref
      @current_visits << Visit.find_by(date: Date.today, position: visitref.position + 1)
    end
  end
end
