class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]

  def index
    @prescriptions = Prescription.all
    @visits = Visit.all
  end

  def show
    @prescription = Prescription.find(params[:id])
    @schedule = []
    if @prescription.lundi == true
      @schedule << "lundi"
    end
    if @prescription.mardi == true
      @schedule << "mardi"
    end
    if @prescription.mercredi == true
      @schedule << "mercredi"
    end
    if @prescription.jeudi == true
      @schedule << "jeudi"
    end
    if @prescription.vendredi == true
      @schedule << "vendredi"
    end
    if @prescription.samedi == true
      @schedule << "samedi"
    end
    if @prescription.dimanche == true
      @schedule << "dimanche"
    end
  end

  def new
    @prescription = Prescription.new
    @current_patient = Patient.find(params[:patient_id])
    if params[:patient_id].present?
      @prescription.patient = Patient.find(params[:patient_id])
    end
  end

  def create
    my_days = []
    @prescription = Prescription.new(prescription_params)
    @current_patient = @prescription.patient
    if @prescription.lundi
      my_days << 1
    end
    if @prescription.mardi
      my_days << 2
    end
    if @prescription.mercredi
      my_days << 3
    end
    if @prescription.jeudi
      my_days << 4
    end
    if @prescription.vendredi
      my_days << 5
    end
    if @prescription.samedi
      my_days << 6
    end
    if @prescription.dimanche
      my_days << 0
    end
    @results = (@prescription.start_at..@prescription.end_at).to_a.select { |d| my_days.include?(d.wday) }
    @results.each do |result|
      visit = Visit.new
      visit.user = current_user
      visit.position = 1000
      visit.is_done = false
      visit.date = result
      visit.prescription = @prescription
      visit.cares = @prescription.cares
      visit.wish_time = @prescription.wish_time
      visit.save
    end

    if @prescription.save
      redirect_to prescription_path(@prescription)
    else
      render :new
    end
  end

  def edit
    @current_prescription = Prescription.find(@prescription.id)
    @current_patient = @current_prescription.patient
  end

  def update
    # @prescription.update(prescription_params)
    #a revoir, les dates des visites liées ne sont pas modifiées en cas de modification de jourdate
    if @prescription.update(prescription_params)
      update = @prescription.visits.select { |d| d.date > Date.today}
      update.each do |update|
        update.destroy
      end
    my_days = []
    if @prescription.lundi
      my_days << 1
    end
    if @prescription.mardi
      my_days << 2
    end
    if @prescription.mercredi
      my_days << 3
    end
    if @prescription.jeudi
      my_days << 4
    end
    if @prescription.vendredi
      my_days << 5
    end
    if @prescription.samedi
      my_days << 6
    end
    if @prescription.dimanche
      my_days << 0
    end
    results = (Date.today..@prescription.end_at).to_a.select { |d| my_days.include?(d.wday) }
      results.each do |result|
        visit = Visit.new
        visit.user = current_user
        visit.position = 1000
        visit.is_done = false
        visit.date = result
        visit.prescription = @prescription
        visit.cares = @prescription.cares
        visit.wish_time = @prescription.wish_time
        visit.save
      end
    end
    redirect_to prescriptions_path(@prescription)
  end

  def destroy
    @prescription.destroy
    redirect_to prescriptions_path
  end

  private

  def prescription_params
    params[:prescription].permit(:title, :start_at, :end_at, :wish_time, :lundi, :mardi, :mercredi, :jeudi, :vendredi, :samedi, :dimanche, :patient_id, care_ids: [])
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

end
