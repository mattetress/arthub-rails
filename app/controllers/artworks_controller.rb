class ArtworksController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @artwork = Artwork.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
