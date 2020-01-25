record = []
100.times do 
	record << Category.new(name: Faker::Commerce.department)
end

record = []
100.times do 
	record << Product.new(name: Faker::Commerce.product_name,category_id: Category.all.sample.id,price: Faker::Commerce.price,stock: Faker::Number.between(25, 100),cod_eligible: Faker::Boolean.boolean,description: Faker::Lorem.paragraph,release_date: Faker::Date.forward(23), image: nil)
end

Product.import record