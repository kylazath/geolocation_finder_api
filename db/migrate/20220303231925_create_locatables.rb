class CreateLocatables < ActiveRecord::Migration[7.0]
  def change
    create_table :locatables do |t|
      t.string :identifiable_by
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
