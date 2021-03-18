class ArticlesController < ApplicationController
  include Paginable

  skip_before_action :authorize!, only: [:index, :show]

  def index
    paginated = paginate(Article.recent)
    render_collection(paginated)
  end

  def show
    article = Article.find(params[:id])
    render json: serializer.new(article)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message, detail: "Here will be nicely formatted response" }
  end

  def serializer
    ArticleSerializer
  end

  def create
    article = Article.new(article_params)
    if article.valid?
      #we will figure that out
    else
      render json: article, adapter: :json_api,
        serializer: ActiveModel::Serializer::ErrorSerializer,
        status: :unprocessable_entity
    end
  end

  private

  def article_params
    ActionController::Parameters.new
  end
end
