# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoItem do
  it 'モデルが valid であること' do
    todo_item = described_class.build(detail: '歯を磨く', status: :done)
    expect(todo_item).to be_valid
  end
end
