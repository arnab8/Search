class PagesController < ApplicationController
  respond_to :json, :xml, :html
  def search
    if params[:q].nil?
      @pages = nil
    else
      if( (params[:ns] == 'all') || (params[:categories] && params[:pages]) )
        @pages = Page.search_in_all(params[:q])
      elsif( (params[:ns] == '14') || params[:categories])
        @pages = Page.search_in_categories(params[:q])
      elsif( (params[:ns] == '0') || params[:pages] )
        @pages = Page.search_in_pages(params[:q])
      else
        @pages = Page.search_in_all(params[:q])        
      end
    end

    respond_with @pages
  end

end
