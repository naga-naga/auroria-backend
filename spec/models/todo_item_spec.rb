# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoItem do
  describe 'todo_list の関連付けについて' do
    it 'TodoItem から辿れる' do
      todo_list = TodoList.create!(title: 'title')
      todo_item = todo_list.todo_items.create!(detail: 'foo', status: :incomplete)

      expect(TodoItem.find(todo_item.id).todo_list).to eq(TodoList.find(todo_list.id))
    end
  end

  describe 'status について' do
    it 'status が incomplete の場合 valid' do
      todo_item = TodoItem.build(detail: 'foo', status: :incomplete)
      expect(todo_item).to be_valid
    end

    it 'status が done の場合 valid' do
      todo_item = TodoItem.build(detail: 'foo', status: :done)
      expect(todo_item).to be_valid
    end

    it 'status が上記以外の場合エラー' do
      expect { TodoItem.build(detail: 'foo', status: :foo) }.to raise_error(ArgumentError)
    end
  end
end
