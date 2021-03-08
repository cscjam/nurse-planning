ActiveAdmin.register Prescription do

  permit_params :title, :start_at, :end_at, :wish_time, :schedule, :patient_id, :team_id, :lundi, :mardi, :mercredi, :jeudi, :vendredi, :samedi, :dimanche

  index do
    selectable_column
    actions
    column :id
    column :title
    column :start_at
    column :end_at
    column :schedule
    column :wish
    toggle_bool_column :lundi
    toggle_bool_column :mardi
    toggle_bool_column :mercredi
    toggle_bool_column :jeudi
    toggle_bool_column :vendredi
    toggle_bool_column :samedi
    toggle_bool_column :dimanche
    column :patient do |prescription|
      link_to prescription.patient.get_full_name, admin_patient_path(prescription.patient)
    end
    column "Nb Visits" do |prescription|
      prescription.visits.count
    end
    column :team do |prescription|
      link_to prescription.team.name, admin_team_path(prescription.team)
    end
  end

  form do |f|
    tabs do
      tab 'Prescription' do
        f.inputs do
          f.input :title
          f.input :start_at
          f.input :end_at
          f.input :schedule
          f.input :wish_time
          f.input :patient, collection: Patient.all.map{|u| [u.get_full_name, u.id]}
          f.input :lundi
          f.input :mardi
          f.input :mercredi
          f.input :jeudi
          f.input :vendredi
          f.input :samedi
          f.input :dimanche
        end
      end
    end
  end

end
