class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: [:show, :edit, :update, :destroy]
  before_action :prescription_params, only: [:create, :update]

  def index
    @prescriptions = Prescription.all
    @visits = Visit.all
  end

  def show
    @prescription = Prescription.find(params[:id])
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
    case @prescription.schedule
    when @prescription.schedule.include?('lundi')
      @my_days << 1
    when @prescription.schedule.include?('mardi')
      @my_days << 2
    end
    @results = (@prescription.start_at..@prescription.end_at).to_a.select { |k| @my_days.include?(k.wday) }

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
    params[:prescription].permit(:title, :start_at, :end_at, :schedule, :patient_id)
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

end
