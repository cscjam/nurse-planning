class MinutesController < ApplicationController
  def create
  end

  private

  def article_params
    params.require(:minute).permit(:content, :photos)
  end
end
