class DashboardsController < ApplicationController
  def show
    @today_visits = Visit.where(date: Date.today)
    @today_visits.sort{|a, b| a<=>b}
    @visits = [@today_visits.find { |visit| !visit.is_done }]
    position = @visits.first&.position || 0
    case position
    when @today_visits.first.position
      @visits.push(@today_visits[position+1], @today_visits[position+2])
    when @today_visits.last.position
      @visits.unshift(@today_visits[position-2], @today_visits[position-1])
    else
      @visits.unshift(@today_visits[position-1]).push(@today_visits[position+1])
    end
    @visits.compact!
  end
end
