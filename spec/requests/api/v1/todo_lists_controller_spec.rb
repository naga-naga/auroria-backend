# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TodoListsController do
  describe 'show' do
    context '指定された TodoList が存在する場合' do
      before do
        get "/api/v1/todo_lists/#{todo_list.id}"
      end

      let!(:todo_list) { create(:todo_list) }

      it '200 が返る' do
        expect(response).to have_http_status(:ok)
      end

      it '指定された TodoList が返る' do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(
          {
            id: todo_list.id,
            title: todo_list.title,
          }
        )
      end
    end

    context '指定された TodoList が存在しない場合' do
      before do
        get '/api/v1/todo_lists/999999'
      end

      it '404 が返る' do
        expect(response).to have_http_status(:not_found)
      end

      it 'エラーメッセージが返る' do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(
          {
            status: 404,
            message: 'Not Found',
          }
        )
      end
    end
  end
end
