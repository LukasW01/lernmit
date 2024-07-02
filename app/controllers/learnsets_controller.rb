class LearnsetsController < InheritedResources::Base
  private

  def learnset_params
    params.require(:learnset).permit(:title, :desc, :user_id)
  end
end
