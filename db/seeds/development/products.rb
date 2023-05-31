10.times do |n|
  name = "農産物です。#{n}"
  user_id = n+1
  description = "説明文です。"
  category = "果物"
  prefecture = "青森県"
  price = 3000
  stock = 20
  product = Product.find_or_initialize_by(name: name)

  if  product.new_record?
      product.name = name
      product.user_id = user_id
      product.description = description
      product.category = category
      product.prefecture = prefecture
      product.price = price
      product.stock = stock
      product.save!
  end
end

puts "products = #{Product.count}"