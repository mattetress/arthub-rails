class ArtworksController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]


  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = @user.artworks.build(artwork_params)

    if @artwork.save
      redirect_to user_artwork_path(@user, @artwork)
    else
      render 'artworks/new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @artwork.update(artwork_params)
      redirect_to user_artwork_path(@user, @artwork)
    else
      render 'artworks/edit'
    end 
  end

  def destroy
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :description, :date, :url, images: [])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

end
