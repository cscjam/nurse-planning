class PatientsController < ApplicationController
  before_action :get_patient, only: [:show]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  private

  def get_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params[:patient].permit(:first_name, :last_name, :address, :compl_address, :phone)
  end
end
