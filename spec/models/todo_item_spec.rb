# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoItem do
  describe 'status について' do
    it 'status が incomplete の場合 valid' do
      todo_item = described_class.build(detail: 'foo', status: :incomplete)
      expect(todo_item).to be_valid
    end

    it 'status が done の場合 valid' do
      todo_item = described_class.build(detail: 'foo', status: :done)
      expect(todo_item).to be_valid
    end

    it 'status が上記以外の場合エラー' do
      expect { described_class.build(detail: 'foo', status: :foo) }.to raise_error(ArgumentError)
    end
  end
end
