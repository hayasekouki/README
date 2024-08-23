class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:info] = '掲示板が作成されました'
      redirect_to boards_path
    else
      flash.now[:danger] = '掲示板の作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id]) #bordsテーブルのidを取得している
    @comment = Comment.new #コメントの新規作成
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
