class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def days
    @days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi"]
  end
end
