10.times do |n|
  postComment_content = "コメント#{n}"
  user_id = 1
  post_id = 1
  postComment = PostComment.find_or_initialize_by(post_id: post_id)

  if  postComment.new_record?
      postComment.user_id = user_id
      postComment.post_id = post_id
      postComment.postComment_content = postComment_content
      postComment.save!
  end
end

puts "postComments = #{PostComment.count}"