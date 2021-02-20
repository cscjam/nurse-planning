ActiveAdmin.register Visit do

  permit_params :date, :position, :time, :user_id, :user, :patient_id, :patient, :is_done, :wish_time,
     visit_cares_attributes: [:id, care_ids: []]


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
          #TODO la modification n'est pas active
          #TODO l'affichage ci-dessous n'est pas celui attendu
          f.input :patient
          f.input :user
          f.input :cares, label: "Soins", as: :tags, collection: Care.all, display_name: :name
          f.button :submit
        end
      end
    end
  end

end
