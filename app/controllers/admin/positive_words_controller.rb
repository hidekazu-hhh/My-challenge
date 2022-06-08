class Admin::PositiveWordsController < Admin::BaseController
  

  def index
    @positive_words = PositiveWord.all
  end

  def new
    @positive_word = PositiveWord.new
  end

  def create
    @positive_word = current_user.positive_words.build(positive_word_params)
      if @positive_word.save
        redirect_to admin_positive_words_path, success: t('defaults.message.created', item: PositiveWord.model_name.human)
      else
        flash.now['danger'] = t('defaults.message.not_created', item: PositiveWord.model_name.human)
        render :new
      end
  end


  def show
  end

  def edit
  end

  private

  def positive_word_params
    params.require(:positive_word).permit(:speaker, :word)
  end

end
