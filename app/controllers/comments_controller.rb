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
    @event = Event.find_by(id: params[:event_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @event = Event.find_by(id: params[:event_id])
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @event
    else
      render "comments/edit"
    end
  end

  def destroy
    @event = Event.find_by(id: params[:event_id])
    @comment = Comment.find(params[:id])
    @comment.delete

    flash[:success] = "Comment has been deleted."
    
    redirect_to @event
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
