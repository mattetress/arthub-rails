class CommentsController < ApplicationController
  before_action :login_required
  before_action :set_event
  before_action :set_comment, except: [:create]
  before_action :owner_required, only: [:edit, :update, :destroy]

  def create
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render partial: "comments/comment_li", locals: { comment: @comment }, layout: false
    else
      render 'events/show'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @event
    else
      render "comments/edit"
    end
  end

  def destroy
    @comment.delete
    flash[:success] = "Comment has been deleted."

    redirect_to @event
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_event
    @event = Event.find_by(id: params[:event_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def owner_required
    return head(:forbidden) unless @comment.user == current_user
  end
end
