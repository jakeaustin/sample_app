class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			flash.keep[:notice] = "Welcome back, #{user.name}!"
			redirect_to root_path
			session[:uid] = user.id

		else
		redirect_to signin_path, :flash => {:error => "Invalid email password combo"}		
		end
	end
	
	def destroy
	
		sign_out if signed_in?
		session[:uid] = nil
		redirect_to root_url
	end
end


