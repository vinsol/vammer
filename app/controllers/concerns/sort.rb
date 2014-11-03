module Sort

  def order_collection(order_by, direction, collection)
    if order_by == 'creator'
      collection.joins(:users).order("users.name #{direction}").page params[:page]
    else
      collection.order(order_by => direction).page params[:page]
    end
  end

  def collection(collection)
    debugger

    if params[:direction]
      if sorting_valid?
        collection = order_collection( params[:order], params[:direction].to_sym, collection)
      else
        redirect_to :root
      end
    else
      collection = order_collection(:created_at, :desc, collection)
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