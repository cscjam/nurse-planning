class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]

  def index
    @patient = Patient.find(params[:patient_id])
    @prescriptions = Prescription.where(patient: @patient)
  end

  def show
  end

  def new
    @prescription = Prescription.new
    if params[:patient_id].present?
      @prescription.patient = Patient.find(params[:patient_id])
    end
  end

  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.patient = Patient.find(params[:patient_id])
    if @prescription.save
      days = @prescription.get_binary_days
      dates = (@prescription.start_at..@prescription.end_at).to_a.select { |d| days[d.wday] }
      dates.each do |date|
        visit = Visit.new(user: current_user, position: 1000, is_done: false, date: date,
          prescription: @prescription, wish_time: @prescription.wish_time)
        if visit.save
          @prescription.cares.each do |care|
            VisitCare.create(visit: visit, care: care)
          end
        end
      end
      redirect_to patient_prescriptions_path(@prescription.patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    #a revoir, les dates des visites liées ne sont pas modifiées en cas de modification de jourdate
    if @prescription.update(prescription_params)
      @prescription.visits.select { |d| d.date > Date.today}.each do |visit|
        visit.destroy
      end
      days = @prescription.get_binary_days
      dates = (Date.today..@prescription.end_at).to_a.select { |d| days[d.wday] }
      dates.each do |date|
        visit = Visit.new(user: current_user, position: 1000, is_done: false, date: date,
                          prescription: @prescription, wish_time: @prescription.wish_time)
        if visit.save
          @prescription.cares.each do |care|
            VisitCare.create(visit: visit, care: care)
          end
        end
      end
    end
    redirect_to patient_path(@prescription.patient)
  end

  def destroy
    @prescription.destroy
    redirect_to patient_path(@prescription.patient)
  end

  private

  def prescription_params
    params[:prescription].permit(:title, :start_at, :end_at, :wish_time,
                                 :lundi, :mardi, :mercredi, :jeudi, :vendredi, :samedi, :dimanche,
                                 :patient_id, :photo, care_ids: [])
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end
end
