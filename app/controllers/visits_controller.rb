class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :update, :destroy, :mark_as_done, :move]


  def index
    @delay = params[:delay] || Date.today.to_s
    delay_integer = @delay.split('-').map { |element| element.to_i }
    if params[:query].present?
      @visits = Visit.includes(:patient, :cares).where(date: params[:query]).order(:position)
    else
      date = Date.new(delay_integer[0], delay_integer[1], delay_integer[2])
      shift(date)
      @visits = Visit.includes(:patient, :cares).where(date: date).order(:position)
    end
    @locomotion = current_user.current_locomotion || 0
    # Si changement : mise @jour de l'utilisateur
    if params[:locomotion].present?
      @locomotion = Journey.locomotions.values.index(params[:locomotion])
      current_user.update({current_locomotion: @locomotion})
    end
    # Mise à jour des trajets
    @journeys = Journey::update_journeys(@visits.to_a, @locomotion)
    respond_to do |format|
      format.html
      format.json { render json: { journeys: @journeys } }
    end
  end

  def update
  end

  def mark_as_done
    @visit.is_done = !@visit.is_done
    @visit.save
    if params["format"] == "dashboards"
      redirect_to root_path
    end
  end

  def destroy
    @visit.destroy
    redirect_to visits_path(delay: params[:delay])
  end

  def move
    @visit.update(position: params[:new])
    @visits = Visit.where(date: @visit.date).order(:position)
    if params[:old].to_i < params[:new].to_i
      for i in params[:old].to_i+1..params[:new].to_i
        position = @visits[i].position
        @visits[i].update(position: position - 1)
      end
    else
      for i in params[:new].to_i..params[:old].to_i+1
        position = @visits[i].position
        @visits[i].update(position: position - 1)
      end
    end
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

  def shift(date)
    @visits = Visit.includes(:patient, :cares).where(date: date).order(:position)
    @visits.each_with_index do |visit, index|
      visit.update(position: index)
    end
  end
end
