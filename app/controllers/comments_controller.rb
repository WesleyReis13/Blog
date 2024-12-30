class CommentsController < ApplicationController
  before_action :set_post

  def create
    # Verifique se o usuário está logado e se não, faça um comentário anônimo
    @comment = @post.comments.build(comment_params)
    if current_user
      @comment.user = current_user  # Associa o comentário ao usuário logado
    end

    if @comment.save
      redirect_to @post, notice: 'Comentário enviado com sucesso.'
    else
      redirect_to @post, alert: 'Erro ao enviar o comentário.'
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
