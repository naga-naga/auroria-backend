# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TodoListsController do
  describe 'index' do
    context 'TodoList が存在する場合' do
      let!(:todo_list1) { create(:todo_list) }
      let!(:todo_list2) { create(:todo_list) }
      let!(:todo_list3) { create(:todo_list) }

      it '200が返る' do
        get '/api/v1/todo_lists'

        expect(response).to have_http_status(:ok)
      end

      context 'limit と offset が整数で渡された場合' do
        let!(:params) { { limit: 1, offset: 1 } }

        it '渡された limit/offset が使われる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list2.id,
              title: todo_list2.title
            )
          )
        end
      end

      context 'limit のみ整数で渡された場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 0)
        end

        let!(:params) { { limit: 1 } }

        it '渡された limit とデフォルトの offset が使われる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list1.id,
              title: todo_list1.title
            )
          )
        end
      end

      context 'offset のみ整数で渡された場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_LIMIT', 1)
        end

        let!(:params) { { offset: 1 } }

        it 'デフォルトの limit と渡された offset が使われる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list2.id,
              title: todo_list2.title
            )
          )
        end
      end

      context 'limit も offset も渡されなかった場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_LIMIT', 10)
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 0)
        end

        let!(:params) { {} }

        it 'デフォルトの limit/offset が使われる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list1.id,
              title: todo_list1.title
            ),
            a_hash_including(
              id: todo_list2.id,
              title: todo_list2.title
            ),
            a_hash_including(
              id: todo_list3.id,
              title: todo_list3.title
            )
          )
        end
      end

      context '渡された limit が大きすぎる場合' do
        before do
          stub_const('Api::V1::TodoListsController::MAX_LIMIT', 2)
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 0)
        end

        let!(:params) { { limit: 1_000_000 } }

        it '最大値までしか返らない' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list1.id,
              title: todo_list1.title
            ),
            a_hash_including(
              id: todo_list2.id,
              title: todo_list2.title
            )
          )
        end
      end

      context '渡された limit が負の整数の場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_LIMIT', 10)
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 0)
        end

        let!(:params) { { limit: -1 } }

        it 'limit が0に丸められる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
        end
      end

      context '渡された offset が負の整数の場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_LIMIT', 1)
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 10)
        end

        let!(:params) { { offset: -1 } }

        it 'offset が0に丸められる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list1.id,
              title: todo_list1.title
            )
          )
        end
      end

      context '渡された limit が整数でない場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_LIMIT', 1)
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 0)
        end

        let!(:params) { { limit: 'string' } }

        it 'デフォルトの limit が使われる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list1.id,
              title: todo_list1.title
            )
          )
        end
      end

      context '渡された offset が整数でない場合' do
        before do
          stub_const('Api::V1::TodoListsController::DEFAULT_LIMIT', 1)
          stub_const('Api::V1::TodoListsController::DEFAULT_OFFSET', 0)
        end

        let!(:params) { { offset: 'string' } }

        it 'デフォルトの offset が使われる' do
          get('/api/v1/todo_lists', params:)

          expect(JSON.parse(response.body, symbolize_names: true)).to contain_exactly(
            a_hash_including(
              id: todo_list1.id,
              title: todo_list1.title
            )
          )
        end
      end
    end

    context 'TodoList が存在しない場合' do
      it '200が返る' do
        get '/api/v1/todo_lists'

        expect(response).to have_http_status(:ok)
      end

      it '空配列が返る' do
        get '/api/v1/todo_lists'

        expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
      end
    end
  end

  describe 'show' do
    context '指定された TodoList が存在する場合' do
      let!(:todo_list) { create(:todo_list) }

      it '200 が返る' do
        get "/api/v1/todo_lists/#{todo_list.id}"

        expect(response).to have_http_status(:ok)
      end

      it '指定された TodoList が返る' do
        get "/api/v1/todo_lists/#{todo_list.id}"

        expect(JSON.parse(response.body, symbolize_names: true)).to eq(
          {
            id: todo_list.id,
            title: todo_list.title,
          }
        )
      end
    end

    context '指定された TodoList が存在しない場合' do
      it '404 が返る' do
        get '/api/v1/todo_lists/999999'

        expect(response).to have_http_status(:not_found)
      end

      it 'エラーメッセージが返る' do
        get '/api/v1/todo_lists/999999'

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
