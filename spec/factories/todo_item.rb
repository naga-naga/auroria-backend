# frozen_string_literal: true

FactoryBot.define do
  factory :todo_item do
    todo_list
    sequence(:detail) { |n| "detail#{n}" }
    status { :incomplete }
  end
end
