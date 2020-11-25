class DashboardsController < ApplicationController
  def show
    @visits = Visit.where(date: Date.today)
    @visits = @visits.sort {|x, y| x.position <=> y.position}
    @visitref = @visits.find {|visit| visit.is_done == false }
    # n'afficher que la première visite dont is_done = false ainsi que le précédente et la suivante
  end
end
