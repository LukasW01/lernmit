ActiveAdmin.register User do
  form partial: 'form'
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :roles
    column :created_at
    actions
  end

  filter :email
  filter :roles
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
