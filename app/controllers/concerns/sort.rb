module Sort

  def collection(collection)

    if params[:direction]
      if sorting_valid?
        collection = collection.order( params[:order] => params[:direction].to_sym).page params[:page]
      else
        redirect_to :index
      end
    else
      collection = collection.order(name: :asc).page params[:page]
    end

  end

end