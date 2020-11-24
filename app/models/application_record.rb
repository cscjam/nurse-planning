class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def get_full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end
end
