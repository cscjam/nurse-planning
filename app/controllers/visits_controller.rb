class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :update]

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
    @visit.is_done ? @visit.is_done = false : @visit.is_done = true
    @visit.save
    redirect_to root_path
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
