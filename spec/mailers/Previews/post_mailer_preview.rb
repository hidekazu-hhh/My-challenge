class PostMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/post_mailer/report_summary 
  
    def report_summary
  
      PostMailer.report_summary
  
    end
  end