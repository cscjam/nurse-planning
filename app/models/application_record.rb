class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def get_full_name
    "#{first_name.present? ? first_name.capitalize : ""} #{last_name.present? ? last_name.upcase : ""}"
  end

  def get_pretty_duration(duration_min)
    hour = duration_min / 60
   "#{hour if hour > 0}#{"h" if hour > 0}#{duration_min % 60}m"
  end
end
