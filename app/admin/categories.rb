ActiveAdmin.register Category do
  permit_params :name

  filter :name
  filter :created_at
end
