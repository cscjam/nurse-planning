class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def days
    ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
  end
end
