class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)

        if @user && @user.authenticate(params[:session][:password])
          session[:user_id] = @user.id
          redirect_to root_path
        else
          flash[:notice] = "There was something wrong with your login details."
          render :new
        end
      end
       
      def destroy
        session[:user_id] = nil
        flash[:notice] = "You have been logged out."
        redirect_to root_path
      end

end