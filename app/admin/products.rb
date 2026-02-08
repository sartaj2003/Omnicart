ActiveAdmin.register Product do
  permit_params :name, :description, :price_cents, :stock, :status, :category_id, :image


  filter :name
  filter :status
  filter :price_cents
  filter :stock
  filter :created_at


  index do
    selectable_column
    id_column

    column :name
    column :category
    column :price_cents
    column :stock
    column :status

    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, width: 60
      end
    end

    column :created_at
    actions
  end


  form do |f|
    f.inputs do
      f.input :category
      f.input :name
      f.input :description
      f.input :price_cents
      f.input :stock
      f.input :status
      f.input :image, as: :file
    end
    f.actions
  end
end
