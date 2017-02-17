class SnippetsController < ApplicationController
  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
    	DpasteWorker.perform_async(@snippet.id)
    	#DpasteWorker.perform_in(1.minute, @snippet.id)
      redirect_to @snippet
    else
      render :new
    end
  end

  private

  def snippet_params
  	params.require(:snippet).permit(:language, :plain_code)
  end
end
