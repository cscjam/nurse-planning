class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]
  before_action :prescription_params, only: [:create]

  def index
    @prescriptions = Prescription.all
    @visits = Visit.all
  end

  def show
    if params[:id] != "new"
    @visits = Visit.where(params[:id])
    else
    @prescription = Prescription.all
    end
  end

  def new
    #if params[:patient_id].present?
      #@prescription = Prescription.new(patient_id: prescription_params)
    #else
      @prescription = Prescription.new
    #end
  end

  def create
    @prescription = Prescription.new(prescription_params)
      if @prescription.save
        redirect_to prescription_path(@prescription)
      else
        render :new
      end
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
    params[:prescription].permit(:title, :start_at, :end_at, :schedule, :patient_id)
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

end
