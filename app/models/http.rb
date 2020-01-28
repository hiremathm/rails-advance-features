class Http < ApplicationRecord
	def self.post url, category, product
		data = {name: "Laptop"}.to_json
		res = Typhoeus.post("http://localhost:3001/create_category", body: { category: data, content: "This is category object"})
	end

	def self.print_name
		name = "shivakumara m"
		puts "name: #{name}"
		# rails r "Http.new.print_name"
	end
end
