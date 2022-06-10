class PostMailer < ApplicationMailer
  def report_summary
	  @created_post_count = Post.created.count

		@post_created_at_yesterday = Post.created_at_yesterday

    mail(to: 'admin@admin.com', subject: '投稿の集計結果')
  end
end
