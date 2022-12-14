class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :email_suffix

      t.timestamps
    end
  end
end
