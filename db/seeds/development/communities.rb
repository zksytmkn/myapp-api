10.times do |n|
  name = "コミュニティです。こちらのコミュニティもサンプルです。#{n}"
  user_id = n+1
  text = "紹介文です。サンプルです。こちらのコミュニティの紹介文ですが、
  サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。紹介文です。サンプルです。こちらのコミュニティの紹介文ですが、 サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。サンプルです。紹介文のように見えますが、サンプルなんです。
  "
  community = Community.find_or_initialize_by(name: name)

  if  community.new_record?
      community.name = name
      community.user_id = user_id
      community.text = text
      community.save!
  end
end

puts "communities = #{Community.count}"