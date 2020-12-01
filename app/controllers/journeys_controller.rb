class JourneysController < ApplicationController
  def geometry
    @journey = Journey.find(params[:id])
    respond_to do |format|
      hash = { journeys: @journey.lines_json }
      format.json { render json: { geometry: JSON.parse(@journey.lines_json) } }
    end
  end
end
