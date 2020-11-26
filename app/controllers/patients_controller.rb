class PatientsController < ApplicationController
  before_action :get_patient, only: [:show]

  def index
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
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
