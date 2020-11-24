class MinutesController < ApplicationController
  def create
    @minute = Minute.new(minute_params)
    @visit = Visit.find(params[:visit_id])
    @minute.visit = @visit
    if @minute.save!
      redirect_to visit_path(@visit)
    else
      render "visits/show"
    end
  end

  private

  def minute_params
    params.require(:minute).permit(:content, :photos)
  end
end
