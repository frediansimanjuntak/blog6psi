class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %w[create update destroy]
  before_action :find_articles, only: %w[show update destroy]

  def index
    articles = Article.all
    render json: {status:"success", data: articles}
  end

  # show detail data GET /articles/:id
  def show
    if @article.present?
      render json: {status:"success", data: @article}
    else
      render json: {status:"failed", data: @article.errors}
    end
  end

  # create data POST /articles
  def create
    article = Article.new(article_params)
    if article.save
      render json: {status:"success", data: article}      
    else
      render json: {status:"failed", messages: article.errors}      
    end
  end

  # update data PUT /articles/:id
  def update
    @article.update(article_params)
    if @article
      render json: {status:"success", data: @article}      
    else
      render json: {status:"failed", messages: @article.errors}  
    end
  end

  # destroy data DELETE /articles/:id
  def destroy
    @article.destroy
    if @article
      render json: {status:"success", messages: "Article deleted successfully"}      
    else
      render json: {status:"failed", messages: @article.errors}  
    end
  end

  private

  def find_articles
    begin      
      @article = Article.find(params[:id])
    rescue => exception
      render json: {status:"failed", messages: exception} 
    end
  end

  def article_params
    # {
    #   article : {
    #     title : "",
    #     content : "",
    #     user_id : ""
    #   }
    # }
    default_input = {user: current_user}
    params.require(:article).permit(:title, :content).reverse_merge(default_input)
  end
end
