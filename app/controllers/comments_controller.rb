class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: params[:content], user: User.find(1), gossip: Gossip.find(params[:gossip_id]))
    
    if @comment.save
      flash[:success] = "Le commentaire a bien été créé !"
      redirect_to gossip_path(params[:gossip_id])
    else
      flash[:error] = "Le commentaire n'a pas été créé."
      redirect_to gossip_path(params[:gossip_id])
    end
  end  

  def edit
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(content: params[:content])
      flash[:success] = "Le commentaire a été modifié avec succès."
      redirect_to gossip_path(params[:gossip_id])
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Le com a été détruit avec succès."
      redirect_to gossip_path(params[:gossip_id])
    else
      flash[:error] = "Le com n'a pas été détruit."
      redirect_to gossip_path(params[:gossip_id])
    end
  end
end
