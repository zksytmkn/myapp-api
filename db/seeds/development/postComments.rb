10.times do |n|
  content = "コメントになります。こちらサンプルですが、
  コメントになります。こちらにコメントを入力することになってます。#{n}"
  user_id = n+1
  post_id = n+1
  postComment = PostComment.find_or_initialize_by(user_id: user_id)

  if  postComment.new_record?
      postComment.user_id = user_id
      postComment.post_id = post_id
      postComment.content = content
      postComment.save!
  end
end

puts "postComments = #{PostComment.count}"