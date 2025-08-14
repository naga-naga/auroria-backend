# frozen_string_literal: true

class TodoItem < ApplicationRecord
  enum :status, {
    incomplete: 'incomplete',
    done: 'done',
  }
end
