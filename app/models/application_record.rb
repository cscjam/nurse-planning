class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  @@DAYS = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]

  def self.get_days
    DAYS
  end
end
