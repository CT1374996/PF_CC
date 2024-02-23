class Admin::ImpressionsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @impressions = Impression.all
  end

  def show
    @impression = Impression.find(params[:id])
  end

  private
  def impression_params
    params.require(:impression).permit(:title, :body)
  end
end
