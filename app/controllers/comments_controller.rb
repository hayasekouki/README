class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      flash[:info] = "コメントが作成されました"
      redirect_to board_path(comment.board)
    else
      flash[:danger] = "コメントの作成に失敗しました"
      redirect_to board_path(comment.board)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
