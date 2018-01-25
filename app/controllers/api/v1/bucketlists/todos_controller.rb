module Api
  module V1
    module Bucketlists
      class TodosController < ApplicationController

        before_action :authenticate_user

        # POST /bucketlists/
        def create_bucketlist
          todo = Todo.new(bucketlist_params.merge({user_id: @current_user}))
          if(todo.save)
            render json: {"message": "Todo created successfully"}, status: 200
          else
            render json: {"message": "Todo NOT created due to the following errors: " + todo.errors.full_messages.join(", ")}, status: 400
          end
        end

        # GET /bucketlists/
        def view_all_bucketlists
          todos = Todo.where(:user_id => @current_user)
          if(todos and !todos.blank?)
            render json: {
              "message": "Bucketlists successfully retrieved",
              "bucketlists": todos
              }, status: 200
          else
            render json: {"message": "Bucketlists NOT found"}, status: 404
          end
        end

        # GET /bucketlists/:id/
        def view_single_bucketlist
          todo = Todo.where(:user_id => @current_user, :id => params[:id])
          if(todo and !todo.blank?)
            render json: {
              "message": "Bucketlist successfully retrieved",
              "bucketlist": todo
              }, status: 200
          else
            render json: {"message": "Bucketlist NOT found"}, status: 404
          end
        end

        # PUT /bucketlists/:id/
        def edit_bucketlist
          todo = Todo.where(:user_id => @current_user, :id => params[:id])
          if(todo and !todo.blank?)
            if(todo.update(bucketlist_params))
              render json: {
                "message": "Bucketlist successfully updated"
                }, status: 200
            else
              render json: {
                "message": "The following errors occured: " + todo.errors.full_messages.join(", ")
                }, status: 500
            end
          else
            render json: {"message": "Bucketlist NOT found"}, status: 404
          end
        end

        # DELETE /bucketlists/:id/
        def delete_bucketlist
          todo = Todo.where(:user_id => @current_user, :id => params[:id])
          if(todo and !todo.blank?)
            if(Todo.delete(params[:id]))
              render json: {
                "message": "Bucketlist successfully deleted"
                }, status: 204
            else
              render json: {
                "message": "The following errors occured: " + todo.errors.full_messages.join(", ")
                }, status: 500
            end
          else
            render json: {"message": "Bucketlist NOT found"}, status: 404
          end
        end

        private def bucketlist_params
          params.permit(:title, :description)
        end

      end
    end
  end
end
