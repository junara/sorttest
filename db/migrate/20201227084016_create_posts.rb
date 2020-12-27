# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
