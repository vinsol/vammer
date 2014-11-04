module Sort

  #FIX:
  # 1. Get params[:direction], if anything except 'desc', use 'asc'
  # 2. Get params[:column], if blank, use created_at
  # 3. if column is 'creator', add logic for this
  # 4. Add logic for other columns
  # Use application controller instead of module if the code sis not too much

  # Add to application controller:
  # def sort_column; end Pt. 2
  # def sort_order; end Pt. 1
  # def sorted_collection; end Pt. 4

  def order_collection(order_by, direction, collection)
    if order_by == 'creator'
      collection.joins(:creator).order("users.name #{direction}").page params[:page]
    else
      collection.order(order_by => direction).page params[:page]
    end
  end

  def collection(collection)
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
      #FIX: No need to check columns
      (['desc', 'asc'].include? params[:direction] and ['name', 'creator'].include?(params[:order]))
    end

    def user_sorting?
      (['desc', 'asc'].include? params[:direction] and ['name', 'email'].include?(params[:order]))
    end

    def sorting_valid?
      params[:controller] == 'groups' ? group_sortng? : user_sorting?
    end

end