class Category < ApplicationRecord

	paginates_per 50
	max_paginates_per 100

	# Callbacks
	after_update :flush_name_cache

	#Mem Cache
	def flush_name_cache
		Rails.cache.delete([:category, id, :name]) if name_changed?
	end


	has_many :products, :dependent => :destroy
	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |category|
				csv << category.attributes.values_at(*column_names)
			end
		end
	end
end
