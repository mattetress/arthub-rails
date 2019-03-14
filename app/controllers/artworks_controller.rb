class ArtworksController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @artwork = Artwork.new
  end

  def create
    @user = User.find(params[:user_id])

    @artwork = @user.artworks.build(artwork_params)

    if @artwork.save
      redirect_to user_artwork_path(@user, @artwork)
    else
      render 'artworks/new'
    end
  end

  def show
    @artwork = Artwork.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :description, :date, :url, images: [] )
  end


end
