10.times do |n|
  name = "農家の呟き#{n}"
  poster = "user#{n}"
  text = "呟きです。サンプルです。"
  post = Post.find_or_initialize_by(name: name)

  if  post.new_record?
      post.name = name
      post.poster = poster
      post.text = text
      post.save!
  end
end

puts "posts = #{Post.count}"