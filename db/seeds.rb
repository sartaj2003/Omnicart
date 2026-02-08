puts "Cleaning DB..."

Product.delete_all
Category.delete_all

categories = [
  "Electronics",
  "Fashion",
  "Home & Kitchen",
  "Beauty & Personal Care",
  "Sports & Fitness",
  "Books",
  "Toys",
  "Groceries",
  "Mobiles",
  "Laptops",
  "Accessories",
  "Furniture",
  "Footwear",
  "Watches",
  "Bags",
  "Gaming",
  "Stationary",
  "Baby Care",
  "Pet Supplies",
  "Kitchen Appliances",
  "Smart Gadgets",
  "Health Care",
  "Gym Wear",
  "Perfumes",
  "Jewellery",
  "Car Accessories",
  "Office Products",
  "Travel Items"
]

puts "Creating categories..."

categories.each do |cat|
  Category.create!(name: cat)
end

puts "Creating products..."

Category.find_each do |category|
  5.times do |i|
    Product.create!(
      name: "#{category.name} Product #{i+1}",
      description: "High-quality #{category.name} item. Durable and best-selling product.",
      price_cents: rand(999..4999) * 100,
      stock: rand(20..100),
      status: true,
      category: category
    )
  end
end

puts "✅ #{Category.count} categories created!"
puts "✅ #{Product.count} products created!"
