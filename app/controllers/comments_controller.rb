class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)

    @comment.user = current_user if user_signed_in?

    if user_signed_in?
      @comment.user = current_user
    end

    if @comment.save
      redirect_to @post, notice: "Comentário criado com sucesso."
    else
      redirect_to @post, alert: "Erro ao criar comentário."
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
