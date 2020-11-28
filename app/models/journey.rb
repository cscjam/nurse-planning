require 'mapbox-sdk'
class Journey < ApplicationRecord
  belongs_to :start_user, :class_name => "User", optional: true
  belongs_to :start_patient, :class_name => "Patient", optional: true
  belongs_to :end_user, :class_name => "User", optional: true
  belongs_to :end_patient, :class_name => "Patient", optional: true

  # traffic, driving, walking, cycling
  enum locomotions: {voiture: "driving", velo: "cycling", marche: "walking"}
  Mapbox.access_token = ENV["MAPBOX_API_KEY"]

  def  get_pretty_infos
    "#{get_pretty_duration(self.duration)} - #{self.distance}m"
  end

  def self.update_journeys(visits, locomotion)
    unless(visits&.empty?)
      # # Ajout de l'infirmier en début&fin de tournée
      # # Passage de visite à patient
      points = [visits.first.user] + visits.map{|p| p.patient} + [visits.last.user]
      get_each_journey_infos(points, locomotion)
    end
  end

  private

  def self.get_each_journey_infos(points, locomotion)
    journeys = []
    points.each_cons(2) do |pair_points|
      journeys << get_one_journey_infos(pair_points , locomotion)
    end
    journeys
  end

  def self.get_one_journey_infos(pair_points, locomotion)
    locomotion = Journey.locomotions[locomotion] unless locomotion.is_a? String
    pair_points.map!{|point|{"longitude" => point.longitude, "latitude" => point.latitude}}
    travel_infos = Mapbox::Directions.directions(pair_points, locomotion)[0]
    if travel_infos["code"] == "Ok"
      return Journey.create(map_api(pair_points, locomotion, travel_infos))
    end
  end

  def self.map_api(pair_points, locomotion, travel_infos)
    map_api= {
      locomotion: locomotion,
      distance: travel_infos["routes"][0]["distance"].to_i,
      duration: travel_infos["routes"][0]["duration"].to_i / 60
    }
    map_api[:start_user] = pair_points.first if pair_points.first.is_a? User
    map_api[:start_patient] = pair_points.first if pair_points.first.is_a? Patient
    map_api[:end_user] = pair_points.second if pair_points.second.is_a? User
    map_api[:end_patient] = pair_points.second if pair_points.second.is_a? Patient
    map_api
  end
end
