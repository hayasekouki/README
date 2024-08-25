class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy, :confirm]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.board_id = params[:board_id]  # 明示的に board_id を設定
    if @comment.save
      flash[:info] = "コメントが作成されました"
      redirect_to board_path(@comment.board)
    else
      flash[:danger] = "コメントの作成に失敗しました"
      redirect_to board_path(@comment.board), status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:info] = 'コメントが更新されました'
      redirect_to board_path(@comment.board)
    else
      render :edit
    end
  end

  def confirm
    # 削除確認のための処理
  end

  def destroy
    @comment.destroy!
    flash[:success] = 'コメントを削除しました'
    redirect_to board_path(@comment.board)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :board_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
