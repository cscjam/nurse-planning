class PatientsController < ApplicationController
  before_action :get_patient, only: [:show]

  def index
    if params[:search].present?
      sql_search = "first_name ILIKE :search OR last_name ILIKE :search"
      @patients = Patient.where(sql_search, search: "%#{params[:search]}%")
    else
      @patients = Patient.all
    end
  end

  def show
    @visits = @patient.visits.order(:date)
    @last_visit_done = @visits.where(is_done: true).last
    @current_patient = @patient
    authorize @visits
    authorize @current_patient
  end

  def new
    @patient = Patient.new
    authorize @patient
  end

  def create
    @patient = Patient.new(patient_params)
    authorize @patient
    @patient.team = current_user.team
    if @patient.save
      redirect_to patient_path(@patient)
    else
      render :new
    end
  end

  private

  def get_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params[:patient].permit(:first_name, :last_name, :address, :compl_address, :phone)
  end
end
