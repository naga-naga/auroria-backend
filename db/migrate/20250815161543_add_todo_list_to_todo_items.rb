# frozen_string_literal: true

class AddTodoListToTodoItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :todo_items, :todo_list, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
