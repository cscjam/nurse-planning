class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :destroy]

  def index
    @days = days
    @delay = params[:delay].to_i || 0

    if params[:query].present?
      @visits = Visit.where(date: params[:query])
    else
      @visits = Visit.where(date: Date.today + @delay)
    end
  end

  def update
  end

  def destroy
    @visit.destroy
    redirect_to visits_path(date: params[:delay])
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
