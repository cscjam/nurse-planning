class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
  def days
    ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
  end
end
