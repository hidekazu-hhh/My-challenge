class PostMailer < ApplicationMailer
  def report_summary

	  @created_post_count = Post.count
    # @created_at_yesterday = Post.created_at_yesterday.count
    @created_at_week_ago = Post.created_at_week_ago.count
    @positive_word = PositiveWord.all.sample # パフォーマンスが悪いため、要修正


    @created_user_count = User.count
    @created_user_week_ago = User.created_user_week_ago.count


    mail(to: 'admin@admin.com', subject: '投稿の集計結果')
  end
end
