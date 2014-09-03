class MailersController < ApplicationController
  def create
  	email = params[:email]
  	subject = params[:subject]
  	body = params[:body]
  	custom_email = Emailer.create email: email, subject: subject, body: body
  	binding.pry
  end
end
