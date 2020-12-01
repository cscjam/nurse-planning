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
    pp visits.length
    unless(visits&.empty?)
      # # Ajout de l'infirmier en début&fin de tournée
      # # Passage de visite à patient
      points = [visits.first.user] + visits.map{|p| p.patient} + [visits.last.user]
      pp points.length
      get_each_journey_infos(points, locomotion)
    end
  end


  def get_markers()
    markers = []
    if(self.start_user)
      markers << {
        lat: self.start_user.latitude,
        lng: self.start_user.longitude,
        infoWindow: JourneysController.new().render_to_string(partial: "marker_info", locals: { point: self.start_user })
      }
    end
    if(self.start_patient)
      markers << {
        lat: self.start_patient.latitude,
        lng: self.start_patient.longitude,
        infoWindow: JourneysController.new().render_to_string(partial: "marker_info", locals: { point: self.start_patient })
      }
    end
    if(self.end_user)
      markers << {
        lat: self.end_user.latitude,
        lng: self.end_user.longitude,
        infoWindow: JourneysController.new().render_to_string(partial: "marker_info", locals: { point: self.end_user })
      }
    end
    if(self.end_patient)
      markers << {
        lat: self.end_patient.latitude,
        lng: self.end_patient.longitude,
        infoWindow: JourneysController.new().render_to_string(partial: "marker_info", locals: { point: self.end_patient })
      }
    end
    return markers
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
    journeys = retrieve_one_journey(pair_points, locomotion)
    return journeys.first unless journeys.none?

    create_one_journey(pair_points, locomotion)
  end

  def self.retrieve_one_journey(pair_points, locomotion)
    # Dans le DB locomotion est un entier 0, 1, 2
    params = {locomotion: locomotion}
    start_key = "start_patient"
    if pair_points.first.is_a? User
      start_key = "start_user"
      params[:start_user] = pair_points.first.id
    else
      params[:start_patient] = pair_points.first.id
    end
    end_key = "end_patient"
    if pair_points.last.is_a? User
      end_key = "end_user"
      params[:end_user] = pair_points.last.id
    else
      params[:end_patient] = pair_points.last.id
    end
    Journey.where("#{start_key}_id = :#{start_key} AND #{end_key}_id = :#{end_key} AND locomotion = :locomotion", params)
  end

  def self.create_one_journey(pair_points, locomotion)
    # Dans l'api locomotion est une string driving, cycling, byking
    api_locomotion = Journey.locomotions.values[locomotion]
    pair_coords = pair_points.map{|point|{"longitude" => point.longitude, "latitude" => point.latitude}}
    travel_infos = Mapbox::Directions.directions(pair_coords, api_locomotion, {geometries: "geojson"})[0]
    if travel_infos["code"] == "Ok"
      return Journey.create(map_api(pair_points, locomotion, travel_infos))
    end
  end

  def self.map_api(pair_points, locomotion, travel_infos)
    map_api= {
      locomotion: locomotion,
      distance: travel_infos["routes"][0]["distance"].to_i,
      duration: travel_infos["routes"][0]["duration"].to_i / 60,
      lines_json: JSON.generate(travel_infos["routes"][0]["geometry"])
    }
    map_api[:start_user] = pair_points.first if pair_points.first.is_a? User
    map_api[:start_patient] = pair_points.first if pair_points.first.is_a? Patient
    map_api[:end_user] = pair_points.second if pair_points.second.is_a? User
    map_api[:end_patient] = pair_points.second if pair_points.second.is_a? Patient
    map_api
  end
end
