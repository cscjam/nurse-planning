class VisitsController < ApplicationController
  before_action :get_visit, only: [:show]

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
  end

  def show
    @minute = Minute.new
  end

  private

  def get_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params[:visit].permit(:date, :position, :time, :wish_time, :is_done)
  end
end
