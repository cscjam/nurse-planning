

class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :update, :destroy]

  def index
    @delay = params[:delay] || Date.today.to_s
    delay_integer = @delay.split('-').map { |element| element.to_i }
    if params[:query].present?
      @visits = Visit.includes(:patient, :cares).where(date: params[:query]).order(:position)
    else
      date = Date.new(delay_integer[0], delay_integer[1], delay_integer[2])
      @visits = Visit.includes(:patient, :cares).where(date: date).order(:position)
    end
    locomotion = params[:locomotion] || :voiture
    @journeys = Journey::update_journeys(@visits.to_a, locomotion)
  end

  def update
    @visit.is_done ? @visit.is_done = false : @visit.is_done = true
    @visit.save
    redirect_to root_path
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
