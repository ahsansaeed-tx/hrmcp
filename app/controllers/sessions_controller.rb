class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in!"
      else
        flash[:alert] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end

    else
      flash[:alert] = "Email or password is invalid"
      render "new"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

end
