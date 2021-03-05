ActiveAdmin.register Minute do

  permit_params :content, :visit_id

  index do
    selectable_column
    actions
    column :id
    column :content
    column :visit
  end

  form do |f|
    tabs do
      tab 'Compte-Rendu' do
        f.inputs do
          f.input :content
          f.input :visit
          f.button :submit
        end
      end
    end
  end

end
