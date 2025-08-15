# frozen_string_literal: true

class CreateTodoLists < ActiveRecord::Migration[8.0]
  def change
    create_table :todo_lists do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
