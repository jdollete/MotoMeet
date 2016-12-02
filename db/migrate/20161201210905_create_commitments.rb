class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.references :user, foreign_key: true, index: true
      t.references :event, foreign_key: true, index: true

      t.datetime(null:false)
    end

  end
end
