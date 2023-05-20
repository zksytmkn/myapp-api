10.times do |n|
  title = "つぶやきです。#{n}"
  user_id = n+1
  body = "呟きです。"
  post = Post.find_or_initialize_by(title: title)

  if  post.new_record?
      post.title = title
      post.user_id = user_id
      post.body = body
      post.save!
  end
end

puts "posts = #{Post.count}"