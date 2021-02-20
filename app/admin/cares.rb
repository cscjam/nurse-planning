ActiveAdmin.register Care do

  permit_params :name, :duration, :icon

  index do
    selectable_column
    actions
    column :id
    column :name
    column :duration
    column :icon
  end

  form do |f|
    tabs do
      tab 'Visite' do
        f.inputs do
          f.input :name
          f.input :duration
          f.input :icon
          f.button :submit
        end
      end
    end
  end

end
