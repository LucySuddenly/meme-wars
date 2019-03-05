class LikesController < ApplicationController

  def create
    Like.create(like_params)
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end

end
