class CommentsController < ApplicationController
  before_action :authenticate_user
  
  def index
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(content: params[:content], user: current_user, gossip: Gossip.find(params[:gossip_id]))
    
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
    
    unless @comment.user == current_user 
      flash[:error] = "Vous n'êtes pas autorisé à modifier ce commentaire."
      redirect_to gossip_path(params[:gossip_id])
    end
  end

  def update
    @comment = Comment.find(params[:id])

    unless @comment.user == current_user
      flash[:error] = "Vous n'êtes pas autorisé à modifier ce commentaire."
      redirect_to gossip_path(params[:gossip_id])
      return
    end

    if @comment.update(content: params[:content])
      flash[:success] = "Le commentaire a été modifié avec succès."
      redirect_to gossip_path(params[:gossip_id])
    else
      render :edit
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
    
    unless @comment.user == current_user || @gossip.user == current_user
      flash[:error] = "Vous n'êtes pas autorisé à supprimer ce commentaire."
      redirect_to gossip_path(params[:gossip_id])
      return
    end

    if @comment.destroy
      flash[:success] = "Le com a été détruit avec succès."
      redirect_to gossip_path(params[:gossip_id])
    else
      flash[:error] = "Le com n'a pas été détruit."
      redirect_to gossip_path(params[:gossip_id])
    end
  end
    

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
  
end
