class CreateCountriesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :demographic_density, null: false

      t.timestamps
    end
  end
end
