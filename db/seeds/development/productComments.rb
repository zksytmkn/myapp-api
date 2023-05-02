10.times do |n|
  content = "コメントです。サンプルです。
  こちらのコメントはサンプルです。実はこちらのコメントサンプルなんです。#{n}"
  user_id = n+1
  product_id = 1
  productComment = ProductComment.find_or_initialize_by(user_id: user_id)

  if  productComment.new_record?
      productComment.user_id = user_id
      productComment.product_id = product_id
      productComment.content = content
      productComment.save!
  end
end

puts "productComments = #{ProductComment.count}"