class PagesController < ApplicationController
  respond_to :json, :xml, :html
  def search
    if params[:q].nil?
      @pages = nil
    else
      @pages = Page.search_in_categories(params[:q] ) if params[:categories]  || (params[:ns] == '14')
      @pages = Page.search_in_pages(params[:q]      ) if params[:pages]       || (params[:ns] == '0')
      @pages = Page.search_in_all(params[:q]        ) if (params[:categories] && params[:pages]) || (params[:ns] == 'all' || (params[:categories].nil? && params[:pages].nil?))
    end
                                                      
    # respond_to do |format|
    #   format.json { render :json => @page_list.to_json }
    #   format.xml { render :xml => @page_list }
    # end
    respond_with @pages
  end

end
