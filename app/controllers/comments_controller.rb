class CommentsController < ApplicationController

  def create
    @event = Event.find_by(id: params[:event_id])
    @comment = @event.comments.build(comment_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end 
end
