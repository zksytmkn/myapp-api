10.times do |n|
  name = "農家の呟きです。サンプルですが、こちらに呟きを入力します。農家の呟きです。サンプルですが、こちらに呟きを入力します。#{n}"
  poster = "useruseruseruser#{n}"
  text = "呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。呟きです。サンプルです。サンプルではありますが、こちらに呟きを入れます。
  呟きのサンプルをこちらに入れることになっております。"
  post = Post.find_or_initialize_by(name: name)

  if  post.new_record?
      post.name = name
      post.poster = poster
      post.text = text
      post.save!
  end
end

puts "posts = #{Post.count}"