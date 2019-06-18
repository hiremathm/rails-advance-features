record = []
100.times do 
	record << Category.new(name: Faker::Commerce.department)
end

50.times do 
	Product.create!(name: Faker::Commerce.product_name,category_id: Category.all.sample.id,price: Faker::Commerce.price,stock: Faker::Number.between(25, 100),cod_eligible: Faker::Boolean.boolean,description: Faker::Lorem.paragraph,release_date: Faker::Date.forward(23), image: nil)
end

record = []
100.times do 
	record << Product.new(name: Faker::Commerce.product_name,category_id: Category.all.sample.id,price: Faker::Commerce.price,stock: Faker::Number.between(25, 100),cod_eligible: Faker::Boolean.boolean,description: Faker::Lorem.paragraph,release_date: Faker::Date.forward(23), image: nil)
end

Product.import record




record = []
100.times do 
	gender = ["M","F"]
	record << User.new(name: Faker::Name.name,age: Random.rand(100),gender: gender.sample, email: Faker::Internet.email, phone: Faker::PhoneNumber.phone_number, created_at: Faker::Date.birthday(1, 5))
end

User.import record