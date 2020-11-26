

class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :destroy]

  def index
    @delay = params[:delay] || Date.today.to_s
    delay_integer = @delay.split('-').map { |element| element.to_i }

    if params[:query].present?
      @visits = Visit.where(date: params[:query])
    else
      @visits = Visit.where(date: Date.new(delay_integer[0], delay_integer[1], delay_integer[2]))
    end
  end

  def update
  end

  def destroy
    @visit.destroy
    redirect_to visits_path(delay: params[:delay])
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
