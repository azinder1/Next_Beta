class CommentsController < ApplicationController
  def create
    @route = Route.find(params[:route_id])
    @comment = Comment.new(comment_params)
    @comment[:user_id] = current_user.id
    @comment[:route_id] = @route.id
    if @comment.save
      respond_to do |format|
        format.html
        format.js
      end
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:content, :rating)
  end
end
