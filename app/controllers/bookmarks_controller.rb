class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = @bookmark.list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie, :list, :comment)
  end
end
