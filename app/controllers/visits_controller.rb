class VisitsController < ApplicationController
  before_action :get_visit, only: [:show, :update, :destroy, :mark_as_done, :move]

  def index
    @delay = params[:delay] || Date.today.to_s
    delay_integer = @delay.split('-').map { |element| element.to_i }
    if params[:query].present?
      @visits = Visit.includes(:prescription, :cares).where(date: params[:query]).order(:position)
    else
      date = Date.new(delay_integer[0], delay_integer[1], delay_integer[2])
      shift(date)
      @visits = Visit.includes(:prescription, :cares).where(date: date).order(:position)
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
      format.csv {
        @visits_planning = Visit.where('date BETWEEN ? AND ?', Date.today, Date.today + 1.week)
          .order(:date, :wish_time)
      }
      format.html
      format.json {
        @markers = @journeys.map(&:get_markers_json)
        render json: { journeys: @journeys, markers: @markers}
      }
    end
  end

  def show
    @minute = Minute.new
    @last_visit_done = @visit.patient.visits.where(is_done: true).last
  end

  def new
    @visit = Visit.new
    if params[:patient_id].present?
      @visit.prescription.patient = Patient.find(params[:patient_id])
    end
    if params[:prescription_id].present?
      @visit.prescription = Prescription.find(params[:prescription_id])
    end
  end

  def create
    @visit = Visit.new(visit_params)
    #TODO, le user est pas celui qui créé
    @visit.user = current_user
    @visit.position = 1000
    @visit.is_done = false
    if @visit.save
      # Si reorder avant le save, il va faire un update sur une visit non sauvegarde
      reorder_by_wishtime(@visit.date)
      redirect_to prescription_path(@visit.prescription)
    else
      render :new
    end
  end

  def update
  end

  def destroy
    date = @visit.date
    @visit.destroy
    shift(date)
    redirect_to visits_path(delay: params[:delay])
  end

  def mark_as_done
    @visit.is_done = !@visit.is_done
    @visit.save
    if params["format"] == "dashboards"
      redirect_to root_path
    end
  end

  # TODO non utilisé ?
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

  private

  def get_visit
    @visit = Visit.find(params[:id])
  end

  def visit_params
    params[:visit].permit(:date, :position, :time, :wish_time, :is_done, :prescription_id, care_ids: [])
  end

  def shift(date)
    @visits = Visit.where(date: date).order(:position)
    @visits.each_with_index do |visit, index|
      visit.update(position: index)
    end
  end

  def reorder_by_wishtime(date)
    @visits = Visit.where(date: date).order(:wish_time, :position)
    @visits.each_with_index do |visit, index|
      visit.update(position: index)
    end
  end
end
