class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.string :address, null: false
      t.datetime :starts_at, null: false

      t.datetime(null:false)
    end
  end
end
