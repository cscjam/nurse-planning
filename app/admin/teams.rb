ActiveAdmin.register Team do
  permit_params :name, patients_attributes: [:id, :_destroy]

  index do
    selectable_column
    actions
    column :id
    column :name
    column "Nb Infirmiers" do |team|
      team.users.count
    end
    column "Nb Patients" do |team|
      team.patients.count
    end
  end

  form do |f|
    tabs do
      tab 'Cabinet' do
        f.inputs do
          f.input :name
          #TODO la modification n'est pas active
          f.input :patients, as: :tags, collection: Patient.all, display_name: :get_full_name
          f.button :submit
        end
      end
    end
  end
end
