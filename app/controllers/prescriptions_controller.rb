class PrescriptionsController < ApplicationController
  def index
    @prescriptions = Prescription.all
    @visits = Visit.all
  end

  def show
    @prescription = Prescription.find(params[:id])
    @visits = Visit.all
  end

  def create
  end

  def new
  end

  def create
  end

  def update
  end

  def delete
  end
end
