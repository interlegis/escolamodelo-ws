class NewsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  def index
    news = News.all
    hash_news = news.map do |c|
      {'id' => c.id,
       'tag' => c.tag,
       'titulo' => c.title,                 
       'link' => c.link,
       'icone' => c.icon
      }
    end
    if !hash_news.empty?
      render status: 200, json: {
          noticias: hash_news,
      }.to_json
    else
      render status: 400, json: {
        mensagem: "Não existe notícias.",
      }.to_json
    end
  end

  # GET /news/1
  def show
    respond_to do |format|
      if @news
        format.json { render :show, status: :ok, location: @news }
      else
        format.json { render json: {"mensagem": "Essa notícia não existe!"}, status: :unprocessable_entity }
      end
    end
  end

  # POST /news
  def create
    @news = News.new(news_params)
    if @news.save
      render status: 200, json: {
        mensagem: "A notícia foi criada com sucesso!",
      }.to_json
    else
      render status: 400, json: {
        mensagem: "Não foi possível criar a notícia.",
      }.to_json
    end
  end

  # PATCH/PUT /news/1
  def update
    respond_to do |format|
      if @news
        if @news.update(news_params)
          format.json { render :show, status: :ok, location: @news }
        else
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: {"mensagem": "Essa notícia não existe!"}, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  def destroy
    respond_to do |format|
      if @news
        if @news.destroy
          format.json { render json: {"mensagem": "Notícia foi excluída com sucesso!"}, status: :ok }
        else
          format.json { render json: @news.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: {"mensagem": "Essa notícia não existe!"}, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_news
      begin
        @news = News.find(params[:id])
      rescue
        @new = nil
      end
    end

    def news_params
      params.require(:news).permit(:tag, :title, :link, :icon)
    end
end
