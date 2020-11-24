class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         belongs_to :team

  has_one_attached :avatar

  def get_full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end
end
