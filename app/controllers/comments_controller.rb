class CommentsController < ApplicationController

  def create
    @event = Event.find_by(id: params[:event_id])
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @event
    else
      render 'events/show'
    end 
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
