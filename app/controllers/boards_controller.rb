class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user)
  end
end
