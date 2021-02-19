class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :prescription
  has_many :visit_cares, dependent: :destroy
  has_many :cares, through: :visit_cares
  has_many :minutes, dependent: :destroy
  has_one :patient, through: :prescription
  validates :date, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_or_equal_than: 0}
  validates :wish_time, presence: true, inclusion: { in: (0..23).to_a }
  validates :is_done, inclusion: { in: [true, false] }

  def get_wish_time
    "#{self.wish_time}-#{self.wish_time+1}h"
  end

  def self.print_positions(label, visits)
    puts visits&.map{|v|v.nil? ? 0 : "#{v.position}:#{v.is_done}"}.join("-")
    puts label+visits.map{|v|"#{v.position}:#{v.is_done}"}.join("-")
  end

  def self.print_id_positions(label, visits)
    puts label+visits&.map{|v|v.nil? ? 0 : "#{v.id}:#{v.position}"}.join("-")
  end

  def self.to_csv(options = {col_sep: ';', force_quotes: true, quote_char: '"' })
    CSV.generate(options) do |csv|
      csv << ["Date", "Heure", "Patient", "Adresse", "Complement", "Téléphone", "Soin"]
      all.each do |visit|
        csv << [visit.date, visit.wish_time, visit.patient.get_full_name, visit.patient.address, visit.patient.compl_address, visit.patient.phone] + visit.cares.map(&:name)
      end
    end
  end

  def care_duration
    self.cares.map(&:duration).sum
  end
end
