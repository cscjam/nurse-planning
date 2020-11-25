class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :update]

  def index
    @visit_type = params[:day] || "today"

    case @visit_type
    when "today"
      @visits = Visit.where(date: Date.today)
    when "tomorrow"
      @visits = Visit.where(date: Date.today + 1)
    when "dayThree"
      @visits = Visit.where(date: Date.today + 2)
    when "dayFour"
      @visits = Visit.where(date: Date.today + 3)
    when "dayFive"
      @visits = Visit.where(date: Date.today + 4)
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
