class Page < ActiveRecord::Base
  
  ns = { :page => '0', :category => '14' }
  ns_col = "page_namespace".to_sym
  scope :in_categories,         where(ns_col => ns[:category]  )
  scope :in_pages,              where(ns_col => ns[:page]      )
  scope :in_all,                where(ns_col => ns.values      )
  scope :search_in_categories,  lambda { |key| search(key).in_categories  }
  scope :search_in_pages,       lambda { |key| search(key).in_pages       }
  scope :search_in_all,         lambda { |key| search(key).in_all         }
  
  def self.search(keywords)
    p = nil
    keywords.split.each do |k|
      p ||= Page.scoped
      p = p.where("UPPER(page_title) LIKE UPPER(?)", "%#{k}%")
    end
    p.limit(10)
  end
  
  def self.to_list pages
    return '' if pages.nil?
    p = pages.map do |p|
      # {:label => p.page_id, :value => p.page_title }
      p.page_title
    end
    p.to_json
  end
  
end
