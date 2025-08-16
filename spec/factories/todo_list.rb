# frozen_string_literal: true

FactoryBot.define do
  factory :todo_list do
    sequence(:title) { |n| "タイトル#{n}" }
  end
end
