# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TodoListsController do
  describe 'show' do
    it '動作確認' do
      get '/api/v1/todo_lists/1'
      expect(response).to have_http_status(:no_content)
    end
  end
end
