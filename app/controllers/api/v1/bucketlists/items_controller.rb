module Api
  module V1
    module Bucketlists
      class ItemsController < ApplicationController

        before_action :authenticate_user

        # POST /bucketlists/:id/items/
        def create_item()
          item = Item.new(item_params.merge({user_id: @current_user, todo_id: params[:id]}))
          if(item.save)
            render json: {"message": "Item created successfully"}, status: 201
          else
            render json: {"message": "Item NOT created due to the following errors: " + item.errors.full_messages.join(", ")}, status: 422
          end
        end

        # GET /bucketlists/:id/items/
        def view_all_items()
          items = Item.where(:user_id => @current_user, :todo_id => params[:id])
          if(items and !items.blank?)
            render json: {
              "message": "Items successfully retrieved",
              "items": items
              }, status: 200
          else
            render json: {"message": "Items NOT found"}, status: 404
          end
        end

        # GET /bucketlists/:id/items/:item_id/
        def view_single_item()
          item = Item.where(:user_id => @current_user, :todo_id => params[:id], :id => params[:item_id])
          if(item and !item.blank?)
            render json: {
              "message": "Item successfully retrieved",
              "item": item
              }, status: 200
          else
            render json: {"message": "Item NOT found"}, status: 404
          end
        end

        # PUT /bucketlists/:id/items/:item_id/
        def edit_item()
          item = Item.where(:user_id => @current_user, :todo_id => params[:id], :id => params[:item_id])
          if(item and !item.blank?)
            if(item.update(item_params))
              render json: {
                "message": "Item successfully updated"
                }, status: 200
            else
              render json: {
                "message": "The following errors occured: " + item.errors.full_messages.join(", ")
                }, status: 422
            end
          else
            render json: {"message": "Item NOT found"}, status: 404
          end
        end

        # DELETE /bucketlists/:id/items/:item_id/
        def delete_item()
          item = Item.where(:user_id => @current_user, :todo_id => params[:id], :id => params[:item_id])
          if(item and !item.blank?)
            if(Item.delete(params[:item_id]))
              render json: {
                "message": "Item successfully deleted"
                }, status: 204
            else
              render json: {
                "message": "The following errors occured: " + item.errors.full_messages.join(", ")
                }, status: 422
            end
          else
            render json: {"message": "Item NOT found"}, status: 404
          end
        end

        private def item_params
          params.permit(:title, :description)
        end

      end
    end
  end
end
