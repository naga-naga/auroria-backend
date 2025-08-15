# frozen_string_literal: true

class TodoList < ApplicationRecord
  has_many :todo_items, dependent: :destroy

  validates :title, exclusion: { in: [nil] }
end
