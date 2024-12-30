class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
  
    def index
      @posts = Post.order(created_at: :desc).page(params[:page]).per(3)

    end
  
    def show
      @post = Post.find(params[:id])
      @comment = Comment.new
    end
  
    def new
      @post = Post.new
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to @post, notice: 'Post criado com sucesso.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post atualizado com sucesso.'
      else
        render :edit
      end
    end
  
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post excluído com sucesso.'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :content)
    end
  end
  