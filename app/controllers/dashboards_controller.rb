class DashboardsController < ApplicationController
  def show
    @today_visits = Visit.includes(:patient, :cares).where(date: Date.today).order(:position)
    @visits = [@today_visits.find { |visit| !visit.is_done }]
    index = @today_visits.index(@visits.first)
    case index
    when 0
      @visits.push(@today_visits[index+1], @today_visits[index+2])
    when @today_visits.length - 1
      @visits.unshift(@today_visits[index-2], @today_visits[index-1])
    else
      @visits.unshift(@today_visits[index-1]).push(@today_visits[index+1])
    end
    @visits.compact!
  end
end
