class ProductsJob < ApplicationJob
	
	# rescue_from(ErrorLoadingsSite) do 
	# 	retry_job wait: 5.minutes, queue: :low_priority
	# end	

	queue_as :default

	def perform(user)
		logger.debug "lskdfjlsdjfldsfjlskdfjsldfjlsdfkl"
		# Mailer.send_file( user).deliver_now
	end
end