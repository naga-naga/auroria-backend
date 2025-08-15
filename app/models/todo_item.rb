# frozen_string_literal: true

class TodoItem < ApplicationRecord
  belongs_to :todo_list

  enum :status, {
    incomplete: 'incomplete',
    done: 'done',
  }
end
