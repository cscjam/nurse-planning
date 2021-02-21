ActiveAdmin.register Visit do

  permit_params :date, :position, :time, :user_id, :patient_id, :is_done, :wish_time,
     visit_cares_attributes: [:id, :care, :care_id]

  scope :all, :default => true
  scope :pasts, association_method: :pasts
  scope :futures, association_method: :futures
  scope :of_the_week, association_method: :of_the_week
  scope :of_the_day, association_method: :of_the_day
  scope :mine do |visits|
    visits.where(user: current_user)
  end

  index do
    selectable_column
    actions
    column :id
    column :date
    column :position
    column :time
    column :wish_time
    toggle_bool_column :is_done
    column :patient do |visit|
      link_to visit.patient.get_full_name, admin_patient_path(visit.patient)
    end
    column :user do |visit|
      link_to visit.user.get_full_name, admin_user_path(visit.user)
    end
    column :team do |visit|
      link_to visit.team.name, admin_team_path(visit.team)
    end
    column "Nb Soins" do |visit|
      visit.cares.count
    end
  end

  form do |f|
    tabs do
      tab 'Visite' do
        f.inputs do
          f.input :date
          f.input :position
          f.input :time
          f.input :wish_time
          f.input :is_done
          f.input :patient, collection: Patient.all.map{|u| [u.get_full_name, u.id]}
          f.input :user, collection: User.all.map{|u| [u.get_full_name, u.id]}
          #TODO la modification n'est pas active
          # f.input :cares, label: "Soins", as: :tags, collection: Care.all, display_name: :name
          f.has_many :visit_cares, for: [:visit_cares, f.object.visit_cares], heading: 'Soins' do |visit_care|
            visit_care.input :care, display_name: :name
          end
          f.button :submit
        end
      end
    end
  end

end
