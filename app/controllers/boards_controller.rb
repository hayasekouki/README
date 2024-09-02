class BoardsController < ApplicationController
  before_action :set_board, only: [:edit, :update, :show, :destroy, :confirm_destroy]
  before_action :check_board_owner, only: [:confirm_destroy]

  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
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

  def edit
  end

  def update
    if @board.update(board_params)
      flash[:info] = '掲示板が更新されました'
      redirect_to @board
    else
      render :edit
    end
  end

  def confirm_destroy
    # @boardはset_boardで設定済み
  end

  def destroy
    @board.destroy!
    flash[:success] = '掲示板を削除しました'
    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def check_board_owner
    unless @board.user_id == current_user.id
      flash[:danger] = 'あなたにはこの掲示板を削除する権限がありません'
      redirect_to boards_path
    end
  end
end
