10.times do |n|
  name = "農産物なんです。#{n}"
  user_id = n+1
  text = "説明文です。サンプルです。説明文のサンプルなんです。
  サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。サンプルの説明文です。説明文を入力するんです。"
  type = "果物"
  prefecture = "青森県"
  price = 3000
  quantity = 1
  stock = 20
  product = Product.find_or_initialize_by(name: name)

  if  product.new_record?
      product.name = name
      product.user_id = user_id
      product.text = text
      product.type = type
      product.prefecture = prefecture
      product.price = price
      product.quantity = quantity
      product.stock = stock
      product.save!
  end
end

puts "products = #{Product.count}"