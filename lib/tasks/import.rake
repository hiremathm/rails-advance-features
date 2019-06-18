namespace :import do

	desc "Importing from CSV file"
	
	task import_csv: :environment do 
		filename = File.join Rails.root, "product-5.csv"
		CSV.foreach(filename, headers: true) do |row|
			product = Product.create(id: row["id"], name: row["name"], price: row["price"], stock: row["stock"], category_id: row["category_id"])
			puts "Product - #{product.errors.full_messages.join(",")}" if product.errors.any?
		end
	end

end
