class VisitsController < ApplicationController
  before_action :get_visit, only: [:show]

  def index
    days
    @delay = params[:delay].to_i || 0
    @visits = Visit.where(date: Date.today + @delay)
  end

  def update
  end

  def destroy
  end

  def show

  end

  private

  def get_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params[:visit].permit(:date, :position, :time, :wish_time, :is_done)
  end
end
