# frozen_string_literal: true

module Api
  module V1
    class TodoListsController < ApplicationController
      DEFAULT_LIMIT = 30
      DEFAULT_OFFSET = 0

      def index
        limit = params.fetch(:limit, DEFAULT_LIMIT)
        offset = params.fetch(:offset, DEFAULT_OFFSET)

        render json: TodoList.limit(limit).offset(offset)
      end

      def show
        todo_list = TodoList.find(params[:id])

        render json: {
          id: todo_list.id,
          title: todo_list.title,
        }
      end
    end
  end
end
