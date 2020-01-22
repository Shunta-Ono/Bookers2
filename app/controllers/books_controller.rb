class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find(@book.user_id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] = 'You have creatad book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
  end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def correct_user
    book = Book.find(params[:id])
    @user = User.find(book.user_id)
    if @user.id != current_user.id
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:user_id, :title, :body)
  end
end
