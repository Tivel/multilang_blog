class PostsController < ApplicationController
  def index
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    unless @category.present?
      render :file => 'public/404.html', :status => :not_found, :layout => false
      return
    end
    @posts = @category.posts.paginate(:page => params[:page], :per_page => 30)
    @users = User.all
  end

  def new
    authorize! :create, Post
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    authorize! :update, @category
    @post = Post.new
    @action = :create
    @users = User.all
    render :new_and_edit
  end

  def create
    authorize! :create, Post
    @users = User.all
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    authorize! :update, @category
    @post = @category.posts.create(post_params)
    if @post.created_at.nil?
      @post.created_at = DateTime.now
    end
    if @post.save
      redirect_to category_posts_path(params[:username], @category.path), :flash => { :success => t('post_created') }
    else
      @action = :create
      render :new_and_edit
    end
  end

  def show
    @users = User.all
    @username = params[:username]
    @post = Post.find(params[:id])
    @category = @post.category
  end

  def edit
    @username = params[:username]
    @users = User.all
    @post = Post.find(params[:id])
    authorize! :update, @post
    @category = @post.category
    @action = :update
    render :new_and_edit
  end

  def update
    @users = User.all
    @username = params[:username]
    @category = Category.find_by(path: params[:category_id])
    @post = Post.find(params[:id])
    authorize! :update, @post
    if @post.update(post_params)
      redirect_to category_post_path(params[:username], @post.category.name, @post), :flash => { :success => t('post_modified') }
    else
      @action = :update
      render :new_and_edit
    end
  end

  def destroy
    @username = params[:username]
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.delete
    redirect_to category_posts_path(@username, @post.category.path), :flash => { :success => t('post_deleted') }
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :english_name, :english_content, :priority, :created_at)
  end
end
