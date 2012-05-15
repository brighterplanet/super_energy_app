class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :user_id
      t.text :data

      t.timestamps
    end
  end
end
