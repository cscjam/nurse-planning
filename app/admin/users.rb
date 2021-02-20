ActiveAdmin.register User do

  permit_params :email,
    :password,
    :password_confirmation,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :first_name,
    :last_name,
    :address,
    :team_id,
    :latitude,
    :longitude,
    :current_locomotion,
    :admin

  index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :address
    column :current_locomotion
    column :admin
    actions
  end

  form do |f|
    tabs do
      tab 'User' do
        f.inputs do
          f.input :email
          f.input :password
          f.input :password_confirmation
          f.input :first_name
          f.input :last_name
          f.input :address
          f.input :current_locomotion
          f.input :admin
          f.button :submit
        end
      end
    end
  end

  controller do
    def update
      return super if params[:user].nil?
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end
end
