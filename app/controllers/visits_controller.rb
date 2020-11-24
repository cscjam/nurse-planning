class VisitsController < ApplicationController
  def index
    @visit_type = params[:day] || "today"

    case @visit_type
    when "today"
      @visits = Visit.where(date: Date.today)
    when "tomorrow"
      @visits = Visit.where(date: Date.today + 1)
    when "dayThree"
      @visits = Visit.where(date: Date.today + 2)
    when "dayFour"
      @visits = Visit.where(date: Date.today + 3)
    when "dayFive"
      @visits = Visit.where(date: Date.today + 4)
    end
  end

  def update
  end

  def destroy
  end

  def show
  end
end
