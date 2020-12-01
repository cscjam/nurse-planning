class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  has_many :visit_cares, dependent: :destroy
  has_many :cares, through: :visit_cares
  has_many :minutes, dependent: :destroy
  validates :date, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_or_equal_than: 0}
  validates :wish_time, presence: true, inclusion: { in: (0..23).to_a }
  validates :is_done, inclusion: { in: [true, false] }


  def self.print_positions(label, visits)
    puts label+visits.map{|v|"#{v.position}:#{v.is_done}"}.join("-")
  end

  def self.print_id_positions(label, visits)
    puts label+visits&.map{|v|v.nil? ? 0 : "#{v.id}:#{v.position}"}.join("-")
  end
end
