ActiveAdmin.register Patient do

  permit_params :first_name, :last_name, :address, :compl_address, :phone, :team_id, :latitude, :longitude

  index do
    selectable_column
    actions
    column :id
    column :first_name
    column :last_name
    column :address
    column :compl_address
    column :phone
    column :team do |patient|
      link_to patient.team.name, admin_team_path(patient.team)
    end
    column "Nb Visites" do |patient|
      patient.visits.count
    end
    column "Nb Visites à venir" do |patient|
      patient.visits.futures.count
    end
  end

  form do |f|
    tabs do
      tab 'Patient' do
        f.inputs do
          f.input :first_name
          f.input :last_name
          f.input :address
          f.input :compl_address
          f.input :phone
          f.input :team
          f.button :submit
        end
      end
    end
  end

end
