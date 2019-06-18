categories = []
100.times do 
	categories << Category.new(name: Faker::Commerce.department)
end
Category.import categories

products = []
100.times do 
	products << Product.new(name: Faker::Commerce.product_name,category_id: Category.all.sample.id,price: Faker::Commerce.price,stock: Faker::Number.between(25, 100),cod_eligible: Faker::Boolean.boolean,description: Faker::Lorem.paragraph,release_date: Faker::Date.forward(23), image: nil)
end
Product.import products

users = []
1000.times do 
	gender = ["M","F"]
	users << User.new(name: Faker::Name.name, email: Faker::Internet.email, created_at: Faker::Date.birthday(1, 5))
end
User.import users