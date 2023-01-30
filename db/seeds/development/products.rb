10.times do |n|
  name = "農産物#{n}"
  seller = "user#{n}"
  text = "説明文です。サンプルです。"
  type = "果物"
  region = "東北地方"
  prefecture = "青森県"
  price = 3000
  quantity = 1
  inventory = 20
  product = Product.find_or_initialize_by(name: name)

  if  product.new_record?
      product.name = name
      product.seller = seller
      product.text = text
      product.type = type
      product.region = region
      product.prefecture = prefecture
      product.price = price
      product.quantity = quantity
      product.inventory = inventory
      product.save!
  end
end

puts "products = #{Product.count}"