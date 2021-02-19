class Prescription < ApplicationRecord
  belongs_to :patient
  has_many :visits, dependent: :destroy
  validates :title, presence: true
  validates :start_at,  presence: true
  validates :end_at, presence: true
  validate :end_date_after_or_equal_start_date

  def end_date_after_or_equal_start_date
    if end_at.present? && start_at.present?
      if end_at < start_at
        errors.add(:end_at, "doit être avant la date début")
      end
    end
  end

end
