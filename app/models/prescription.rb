class Prescription < ApplicationRecord
  belongs_to :patient
  has_one :team, through: :patient
  has_many :visits, dependent: :destroy
  has_many :prescription_cares, dependent: :destroy
  has_many :cares, through: :prescription_cares
  has_one_attached :photo
  validates :title, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :end_date_after_or_equal_start_date

  accepts_nested_attributes_for :patient

  def end_date_after_or_equal_start_date
    if end_at.present? && start_at.present?
      if end_at < start_at
        errors.add(:end_at, "doit être avant la date début")
      end
    end
  end

  def get_binary_days
    [lundi, mardi, mercredi, jeudi, vendredi, samedi, dimanche]
  end


  def get_schedule_txt
    schedule = []
    if lundi
      schedule << "L"
    end
    if mardi
      schedule << "Ma"
    end
    if mercredi
      schedule << "Me"
    end
    if jeudi
      schedule << "J"
    end
    if vendredi
      schedule << "V"
    end
    if samedi
      schedule << "S"
    end
    if dimanche
      schedule << "D"
    end
    schedule.join(", ")
  end

private

  def prescription_params
    params.require(:prescription).permit(:title, :wish_time, :photo)
  end
end
