10.times do |n|
  productComment_content = "コメント#{n}"
  user_id = 1
  product_id = 1
  productComment = ProductComment.find_or_initialize_by(product_id: product_id)

  if  productComment.new_record?
      productComment.user_id = user_id
      productComment.product_id = product_id
      productComment.productComment_content = productComment_content
      productComment.save!
  end
end

puts "productComments = #{ProductComment.count}"