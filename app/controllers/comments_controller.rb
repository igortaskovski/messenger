class CommentsController < ApplicationController
  before_action :find_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    if user_signed_in? 
      @comment.user_id = current_user.id
    else
      redirect_to new_user_session_path
    end

    if @comment.save
      redirect_to @post
    else
      flash.now[:danger] = "error"
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
