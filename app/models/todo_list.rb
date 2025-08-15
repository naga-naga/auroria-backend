# frozen_string_literal: true

class TodoList < ApplicationRecord
  validates :title, exclusion: { in: [nil] }
end
