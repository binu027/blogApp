class ArticlesController < ApplicationController

	before_filter :find_article, except: [:index, :new, :create ]
  
  def index
    @articles = Article.all
  end
  
  def show
    
  end
  
  def new
  	@article = Article.new
  end

  def create

    @article = Article.new(article_params)

    @article.user = current_user

    if @article.save
    	redirect_to @article
    	flash[:notice] = "Successfully created..."
    else
    	render  :new
    	flash[:error] = @article.errors.full_messages.to_sentence
    end

  end
  
  def edit
    
  end
  
  def update
  	@article = Article.find(params[:id])
  	
  	if @article.update(article_params)
  		redirect_to @article
  		flash[:notice] = "Successfully updated..."
  	else
  		render :edit
  		flash[:error] = @article.errors.full_messages.to_sentence
  	end

  end

  def destroy
    
    if @article.destroy
    	redirect_to article_path method: :delete
    	flash[:notice] = "Successfully deleted..."
    end

  end

  private 

    def article_params
    	params.require(:article).permit(:title, :content)
    end

    def find_article
    	@article = Article.find(params[:id])
    end

end
