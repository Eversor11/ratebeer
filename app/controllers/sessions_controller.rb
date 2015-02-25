class SessionsController < ApplicationController
	def new
	end

	def create_oauth
		name = env["omniauth.auth"]["info"]["nickname"]
		user = User.find_by(username:name)

		if user.nil?
			user = User.create! username:name, password:'Lihapulla1', password_confirmation:'Lihapulla1'
		end

		session[:user_id] = user.id
		redirect_to user_path(user), notice: "Welcome back!"
	end

	def create
		user = User.find_by username: params[:username]
		if user && user.authenticate(params[:password])
			if user.frozn
				redirect_to :back, notice: "Your account is frozen, please contact admin"
			else
				session[:user_id] = user.id
		    	redirect_to user_path(user), notice: "Welcome back!"
		    end
		else
			redirect_to :back, notice: "Username and/or password mismatch"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to :root
	end
end