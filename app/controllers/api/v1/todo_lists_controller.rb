# frozen_string_literal: true

module Api
  module V1
    class TodoListsController < ApplicationController
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
