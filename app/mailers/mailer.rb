class Mailer < ActionMailer::Base
	default  from: "shivasorab@gmail.com" #, to: -> {User.pluck(:email)}

	def send_otp(user_id, otp)
		@otp = otp
		@user = User.find(user_id)
		mail(:to => @user.email, subject: "Please Enter the OTP to process your login")
 	end

 	def send_file( user)
 		# @file = file
 		@user = user
 		# attachments.inline['product.csv'] = open(file).read
   		mail(to: @user.email,subject: "Your file is uploaded successfully.") do |format|
 			format.html {render 'send_file'}
 			format.text {render plain: 'send_file'}
 		end
 	end
end