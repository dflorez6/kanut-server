module Api
  module V1
    class UsersController < ApplicationController
      # before_action :authenticate_v1_api_user!
      before_action :set_user, only: %i[ show update destroy ]
      before_action :authenticate_user!, only: %i[ index ]

      # GET /usersGPT
      # GET /usersGPT.json
      def index
        @users = User.all
        render json: @users, status: 200
      end

      # GET /usersGPT/1
      # GET /usersGPT/1.json
      def show
        render json: @user, status: 200
      end

      # POST /usersGPT
      # POST /usersGPT.json
      def create
        @user = User.new(user_params)

        if @user.save
          render :show, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /usersGPT/1
      # PATCH/PUT /usersGPT/1.json
      def update
        if @user.update(user_params)
          render :show, status: :ok, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /usersGPT/1
      # DELETE /usersGPT/1.json
      def destroy
        if @user
          @user.destroy!
          render json: { message: "User successfully deleted" }, status: 200
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :name)
      end
    end

  end
end