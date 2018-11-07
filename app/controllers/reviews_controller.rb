class ReviewsController < ApplicationController
  before_action :set_review, only: [:atualizar, :deletar]
  skip_before_action :verify_authenticity_token

  def index
    @reviews = Review.all
    render json:@reviews
  end

  def criar
    @review = Review.new(review_params)
    if @review.save
      render status: 200, json: {
          message: "Sua análise foi criada com sucesso",
      }.to_json
    else
      render status: 400, json: {
          message: "Não foi possível criar a análise",
      }.to_json
    end
  end

  def atualizar
    if @review.update(review_params)
      render status: 200, json: {
          message: "Análise atualizada com sucesso",
      }.to_json
    else
      render status: 400, json: {
          message: "Não foi possível atualizar a análise",
      }.to_json
    end
  end

  def deletar
    if @review.destroy
      render status: 200, json: {
          message: "Análise removida com sucesso",
      }.to_json
    else
      render status: 400, json: {
          message: "Não foi possível remover a análise",
      }.to_json
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:autor, :cargo, :cidade, :uf, :opiniao)
    end
end
