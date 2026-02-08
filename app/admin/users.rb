ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  # ✅ Only define SAFE filters manually
  remove_filter :reset_password_token
  remove_filter :encrypted_password
  remove_filter :remember_created_at
  remove_filter :reset_password_sent_at

  filter :email
  filter :created_at


  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
