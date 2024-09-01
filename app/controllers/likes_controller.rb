class LikesController < ApplicationController
  protect_from_forgery with: :null_session # APIの場合はCSRF対策を無効化することがある

  def update_like_count
    question_id = params[:question_id]
    like_count = params[:like_count].to_i

    # データベースの質問を検索
    @question = Question.find_by(id: question_id)

    if @question
      # 「いいね」数を更新
      @question.update(like_count: like_count)

      # レスポンスを返す
      render json: { status: 'success', like_count: @question.like_count }
    else
      render json: { status: 'error', message: 'Question not found' }, status: :not_found
    end
  end
end