class MinutesController < ApplicationController
  def create
    @visit = Visit.find(params[:visit_id])
    @minute = Minute.new(minute_params)
    @minute.visit = @visit
    if @minute.save
      redirect_to visit_path(@visit)
    else
      render "visits/show"
    end
  end

  private

  def minute_params
    params.require(:minute).permit(:content, photos: [])
  end
end

