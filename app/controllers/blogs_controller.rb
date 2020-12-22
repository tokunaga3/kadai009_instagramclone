class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blog = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def show
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "つぶやきを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"あなたのつぶやきを削除しました！"
  end

  def create
    # @blog = Blog.create(blog_params)
    # binding.irb
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to new_blog_path
    else
      render :new
    end
  end

  def blog_params
    params.require(:blog).permit(:name)
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
    if @blog.user_id == current_user.id
    else
      redirect_to blogs_path, notice: "ログインユーザーが違うので編集できません"
    end
  end

end
