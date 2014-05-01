class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
			session[:uid] = user.id

		else
			flash.now[:error] = 'Invalid email/password combo'
			render 'new'
		end
	end
	
	def destroy
	
		sign_out if signed_in?
		session[:uid] = nil
		redirect_to root_url
	end

end
