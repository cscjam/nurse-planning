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
    @visits_planning = Visit.where('date BETWEEN ? AND ?', Date.today, Date.today + 1.week)
                            .order(:date, :wish_time)
    @journeys = Journey::update_journeys(@visits.to_a, @locomotion)
    respond_to do |format|
      format.csv
      format.json { render json: { journeys: @journeys } }
      format.html
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
    date = @visit.date
    @visit.destroy
    shift(date)
    redirect_to visits_path(delay: params[:delay])
  end

  def move
    @visits = Visit.where(date: @visit.date).order(:position)
    if params[:old].to_i < params[:new].to_i
      for i in params[:old].to_i+1..params[:new].to_i
        position = @visits[i].position
        @visits[i].update(position: position - 1)
      end
    else
      for i in params[:new].to_i..params[:old].to_i-1
        position = @visits[i].position
        @visits[i].update(position: position + 1)
      end
    end
    @visit.update(position: params[:new])
  end

  def show
    @minute = Minute.new
    @current_patient = @visit.patient
  end

  def new
    if params[:patient_id].present?
      @visit = Visit.new(patient_id: params[:patient_id])
    else
      @visit = Visit.new
    end
  end

  def create
    @visit = Visit.new(visit_params)
    @visit.user = current_user
    @visit.position = 1000
    @visit.is_done = false
    if @visit.save
      # Si reorder avant le save, il va faire un update sur une visit non sauvegarde
      reorder_by_wishtime(@visit.date)
      redirect_to visit_path(@visit)
    else
      render :new
    end
  end

  private

  def get_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params[:visit].permit(:date, :position, :time, :wish_time, :is_done, :patient_id, care_ids: [])
  end

  def reorder_by_wishtime(date)
    @visits = Visit.where(date: date).order(:wish_time, :position)
    @visits.each_with_index do |visit, index|
      visit.update(position: index)
    end
  end

  def shift(date)
    @visits = Visit.where(date: date).order(:position)
    @visits.each_with_index do |visit, index|
      visit.update(position: index)
    end
  end
end
