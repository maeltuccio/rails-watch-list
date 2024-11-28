class BookmarksController < ApplicationController

  #formulaire d'ajout d'un signet
  def new
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build
    @movies = Movie.all
  end

  def create
    @list = List.find(params[:list_id])

    @bookmark = @list.bookmarks.build(bookmark_params)
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Film ajouté à la liste.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to @list, notice: 'Signet supprimé.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
