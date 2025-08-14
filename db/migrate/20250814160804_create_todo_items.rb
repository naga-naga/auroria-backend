# frozen_string_literal: true

class CreateTodoItems < ActiveRecord::Migration[8.0]
  def change
    create_table :todo_items do |t|
      t.string :detail
      t.string :status
      t.timestamps
    end
  end
end
