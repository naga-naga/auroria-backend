# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoList do
  describe 'todo_items の関連付けについて' do
    it 'TodoList から辿れる' do
      todo_list = described_class.create!(title: 'title')
      todo_item = todo_list.todo_items.create!(detail: 'foo', status: :incomplete)

      expect(described_class.find(todo_list.id).todo_items).to contain_exactly(TodoItem.find(todo_item.id))
    end

    it 'TodoList を消すと TodoItem も消える' do
      todo_list = described_class.create!(title: 'title')
      todo_list.todo_items.create!(detail: 'foo', status: :incomplete)

      expect { todo_list.destroy! }.to change(TodoItem, :count).by(-1)
    end
  end

  describe 'title について' do
    it '空文字列でない文字列の場合 valid' do
      todo_list = described_class.build(title: 'foo')
      expect(todo_list).to be_valid
    end

    it '空文字列の場合 valid' do
      todo_list = described_class.build(title: '')
      expect(todo_list).to be_valid
    end

    it 'nil の場合 invalid' do
      todo_list = described_class.build(title: nil)
      expect(todo_list).not_to be_valid
    end
  end
end
