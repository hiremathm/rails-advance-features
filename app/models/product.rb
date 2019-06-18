class Product < ApplicationRecord
	paginates_per 10
	max_paginates_per 100
	attr_accessor :file_file_name
	attr_accessor :file_content_type
	has_attached_file :file
	has_attached_file :image, styles: {medium: "300*300>", lerge: "400*400>", thumb: "100*100#"}#, default_url: "/images/:style"

	belongs_to :category, required: true
	# validates_presence_of :description
	validates :image, :attachment_content_type => { :content_type => ['image/png', 'image/jpg']}
	validates :file, :attachment_content_type => {:content_type => ['text/csv', 'application/xls','application/xlsx']}
	# validates_with AttachmentPresenceValidator, attributes: :image
	validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

	#Scope
	scope :cod, -> {where(:cod_eligible => 'true')}

	scope :category, lambda {joins(:category).where('category_id = ?', 1)}

	
	#Mem Cache 
	def category_name
		Rails.cache.fetch([:category, category_id, :name], expires_in: 5.minutes) do 
			category.name
		end
	end


	def self.export_to_csv(options = {})
		desired_attributes = ["id", "name", "price","stock","category_id"]
		CSV.generate(options) do |csv|
			csv << desired_attributes
			all.each do |product|
				csv << product.attributes.values_at(*desired_attributes)
			end
		end
	end

	def self.export_excelx
		p = Axlsx::Package.new
		p.workbook.add_worksheet(:name => "products") do |sheet|
			sheet.add_row ["id", "name", "price", "category", "stock", "description", "cod", "date"]
			all.each do |product|
				sheet.add_row [product.id, product.name, product.price, product.category_id, product.stock, product.description, product.cod_eligible, product.release_date]
			end
		end
		p.use_shared_strings = true	
		p.serialize('sample.xlsx')
		# send_file 'simple.xlsx', :type=>"application/xlsx", :x_sendfile=>true
	end

	def self.import_file(file, user)
		extension = File.extname(file.original_filename)
  		if extension == ".csv" or extension == ".xlsx"
  			spreadsheet = Roo::Spreadsheet.open(file.path)
  			header = spreadsheet.row(1)
	  		(2..spreadsheet.last_row).each do |i|
	    		row = Hash[[header, spreadsheet.row(i)].transpose]
	    		product = find_by(id: row["id"]) || new
	    		product.attributes = row.to_hash
	    		product.save!
	  		end
  		elsif extension == ".xls"
  			workbook = Spreadsheet.open(file.path) #'file.xls'
  			worksheets = workbook.worksheets
  			worksheets.each do |worksheet|
  				worksheet.each 1 do |row|
  					if !Product.find(row[0]).present?
  						Product.create(id: row[0], name: row[1], price: row[2], category_id: row[3], stock: row[4], description: row[5], cod_eligible: row[6], release_date: row[7])
   					end
  				end
  			end
  		end
  		# Mailer.send_file(file, user).deliver_now
  		# file_path_to_save_to = "#{Rails.root}" 
  		# File.write(file_path_to_save_to, file.read)
  		ProductsJob.set(wait: 2.minutes).perform_later(user)
	end

	# def self.import_to_csv(file)
	# 	products = []
	# 	products = CSV.parse(file.path, headers: true)
	# 	CSV.foreach(file.path, headers: true) do |row|
	# 		products << (Product.create! row.to_hash)
	# 		Product.create! row.to_hash
	# 	end

	#Take some fields from imported CSV and append into new CSV
		# columns = ["name", "price"]
		# CSV.open(filename, 'w') do |csv|
		# 	csv << columns
		# 	products.each do |product|
		# 	csv << product.attributes.values_at(*columns)
		# 	end
		# end
	# end

	def self.create_at_ott(product)
		Http.post "#{API_URL}","Category", "#{product}"
	end
end