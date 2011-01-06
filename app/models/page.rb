class Page < ActiveRecord::Base
  
  ns = { :page => '0', :category => '14' }
  ns_col = "page_namespace".to_sym
  scope :in_categories,         where(ns_col => ns[:category]  )
  scope :in_pages,              where(ns_col => ns[:page]      )
  scope :in_all,                where(ns_col => ns.values      )
  scope :search_in_categories,  lambda { |q| search(q).in_categories  }
  scope :search_in_pages,       lambda { |q| search(q).in_pages       }
  scope :search_in_all,         lambda { |q| search(q).in_all         }
  
  def self.search(keywords)
    p = nil
    keywords.split.each do |q|
      p ||= Page.scoped
      p = p.where("UPPER(page_title) REGEXP UPPER(?)", "(^|\_)#{q}")
    end
    p.limit(64)
  end
  
end
