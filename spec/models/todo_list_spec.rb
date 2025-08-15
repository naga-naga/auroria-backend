# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoList do
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
