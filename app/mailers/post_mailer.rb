class PostMailer < ApplicationMailer
  def report_summary

	  @created_post_count = Post.count

    mail(to: 'admin@admin.com', subject: '投稿の集計結果')
  end
end
