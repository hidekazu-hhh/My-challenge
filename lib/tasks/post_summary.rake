namespace :post_summary do
  desc '管理者に対して総投稿数、昨日の投稿数をメールで送信'
  task mail_post_summary: :environment do
    PostMailer.report_summary.deliver_now
  end
end
