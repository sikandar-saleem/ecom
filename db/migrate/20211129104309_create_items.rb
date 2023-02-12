# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.citext  :title,        null: false, unique: true
      t.string  :description,  null: false
      t.float   :price,        null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
