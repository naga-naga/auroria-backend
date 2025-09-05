# frozen_string_literal: true

module Api
  module V1
    class TodoListsController < ApplicationController
      DEFAULT_LIMIT = 30
      DEFAULT_OFFSET = 0
      MAX_LIMIT = 100

      def index
        limit = normalize_limit(params[:limit])
        offset = normalize_offset(params[:offset])

        render json: TodoList.limit(limit).offset(offset)
      end

      def show
        todo_list = TodoList.find(params[:id])

        render json: {
          id: todo_list.id,
          title: todo_list.title,
        }
      end

      private

      def normalize_limit(raw_limit)
        return DEFAULT_LIMIT if raw_limit.nil?

        limit = Integer(raw_limit, exception: false)

        return DEFAULT_LIMIT if limit.nil?

        limit.clamp(0, MAX_LIMIT)
      end

      def normalize_offset(raw_offset)
        return DEFAULT_OFFSET if raw_offset.nil?

        offset = Integer(raw_offset, exception: false)

        return DEFAULT_OFFSET if offset.nil?

        offset.clamp(0, nil)
      end
    end
  end
end
