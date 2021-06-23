class DashboardsController < ApplicationController
  def show
    @today_visits = Visit.includes(:prescription, :cares).where(date: Date.today).order(:position)
    visitref = @today_visits.find { |visit| !visit.is_done }
    index = @today_visits.index(visitref)
    @visits = []
    case index
    when 0
      # quand aucune visite n'est faite
      @visits << visitref
      @visits << @today_visits[index + 1]
      @visits << @today_visits[index + 2]
    when @today_visits.length - 1
      @visits << @today_visits[index - 2]
      @visits << @today_visits[index - 1]
      @visits << visitref
      # quand il ne reste que la dernière visite à faire
    when nil
      # quand toutes les visites sont faites
      @visits << @today_visits[@today_visits.length - 3]
      @visits << @today_visits[@today_visits.length - 2]
      @visits << @today_visits.last
    else
      # dans tous les autres cas
      @visits << @today_visits[index - 1]
      @visits << visitref
      @visits << @today_visits[index + 1]
    end
    @visits.compact!
    @progress = 100
    if @today_visits.length > 0 && index!=nil
      @progress = visitref.position*100/@today_visits.length
    end
  end
end
