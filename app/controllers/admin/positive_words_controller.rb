class Admin::PositiveWordsController < Admin::BaseController
  before_action :set_positive_word, only: %i[edit update show destroy]

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

  def edit; end

  def update
    if @positive_word.update(positive_word_params)
      redirect_to admin_positive_word_path(@positive_word), success: t('defaults.message.updated', item: PositiveWord.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: PositiveWord.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @positive_word.destroy!
    redirect_to admin_positive_words_path, success: t('defaults.message.deleted', item: PositiveWord.model_name.human)
  end


  private

  def set_positive_word
    @positive_word = PositiveWord.find(params[:id])
  end

  def positive_word_params
    params.require(:positive_word).permit(:speaker, :word)
  end

end
