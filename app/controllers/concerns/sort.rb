module Sort

  def collection(collection)

    if params[:direction]
      if sorting_valid?
        collection = collection.order( params[:order] => params[:direction].to_sym).page params[:page]
      else
        redirect_to :index
      end
    else
      collection = collection.order(created_at: :desc).page params[:page]
    end

  end

  private

    def group_sortng?
      (['desc', 'asc'].include? params[:direction] and ['name', 'creator'].include?(params[:order]))
    end

    def user_sorting?
      (['desc', 'asc'].include? params[:direction] and ['name', 'email'].include?(params[:order]))
    end

    def sorting_valid?
      params[:controller] == 'groups' ? group_sortng? : user_sorting?
    end

end