class DashboardsController < ApplicationController
  def show
    @visits = Visit.where(date: Date.today)
  end
end
