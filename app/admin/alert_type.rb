ActiveAdmin.register AlertType do
  scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }
  permit_params :name, :agency_id, :description
  
  filter :name

  index do
    column :id
    column :name
    column :slug
    column :created_at
    column :agency if current_user.has_role? :admin

    default_actions
  end

  form do |f|
    f.inputs "Alert Type" do
      f.input :name, :required => true
      f.input :description, :required => true
      if current_user.has_role? :admin
        f.input :agency, :required => true, :default => current_user.agency.id
      else
        f.input :agency_id, as: :hidden, :value => current_user.agency.id
      end
    end
    
    f.actions
  end

  show do |alert_type|
    h3 alert_type.name
    attributes_table do
      row :name
      row :slug
      row :agency
      row :description
    end
  end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
