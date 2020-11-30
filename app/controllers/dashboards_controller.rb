class DashboardsController < ApplicationController
  def show
    @today_visits = Visit.includes(:patient, :cares).where(date: Date.today).order(:position)
    visitref = @today_visits.find { |visit| !visit.is_done}
    index = @today_visits.index(visitref) || 0
    @visits = []
    case index
    when 0
      @visits << visitref
      @visits << @today_visits[index+1]
      @visits << @today_visits[index+2]
    when @today_visits.length - 1
      @visits << @today_visits[index-2]
      @visits << @today_visits[index-1]
      @visits << visitref
    else
      @visits << @today_visits[index-1]
      @visits << visitref
      @visits << @today_visits[index+1]
    end
    @visits.compact!
  end
end
