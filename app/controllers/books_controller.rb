class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @user=User.find_by(profile_id: params[:uid], profile_type: "AdminProfile")
    @books = Book.all
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create

    @book = Book.new(book_params)
    @book.issued=false
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update

    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy

    if @book.issued 
      flash[:danger]="Delete Failed! Book Is Currently Issued."
      redirect_to '/admin/'+current_user.profile_id.to_s and return
    end

    @book.destroy
    #redirect_to books_url, notice: 'Book was successfully destroyed.'
    redirect_to( {action:'index',uid:current_user.profile_id.to_s}, notice: 'Book was successfully destroyed.')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :author, :bookId)
    end
end
