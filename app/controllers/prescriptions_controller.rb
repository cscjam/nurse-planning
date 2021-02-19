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
    if params[:patient_id].present?
      @prescription.patient = Patient.find(params[:patient_id])
    end
  end

  def create
    @my_days = []
    @prescription = Prescription.new(prescription_params)
    if @prescription.lundi == true
      @my_days << 1
    end
    if @prescription.mardi == true
      @my_days << 2
    end
    if @prescription.mercredi == true
      @my_days << 3
    end
    if @prescription.jeudi == true
      @my_days << 4
    end
    if @prescription.vendredi == true
      @my_days << 5
    end
    if @prescription.samedi == true
      @my_days << 6
    end
    if @prescription.dimanche == true
      @my_days << 0
    end
    @results = (@prescription.start_at..@prescription.end_at).to_a.select { |k| @my_days.include?(k.wday) }
    @results.each do |result|
      visit = Visit.new
      visit.user = current_user
      visit.position = 1000
      visit.is_done = false
      visit.date = result
      visit.prescription = @prescription
      visit.wish_time = 9
      visit.save
    end

    if @prescription.save
      redirect_to prescription_path(@prescription)
    else
      render :new
    end
    # results.each do |result|
    #   Visit.new(date: result)
    # end
  end

  def update
    @prescription.update(prescription_params)
    redirect_to prescriptions_path(@prescription)
  end

  def destroy
    @prescription.destroy
    redirect_to prescriptions_path
  end

  private

  def prescription_params
    params[:prescription].permit(:title, :start_at, :end_at, :lundi, :mardi, :mercredi, :jeudi, :vendredi, :samedi, :dimanche, :patient_id)
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

end
