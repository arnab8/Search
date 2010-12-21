class Page < ActiveRecord::Base
  self.table_name = 'vaniquotes_page'

  def self.search_all(keywords)
    p = nil
    keywords.each do |k|
      p ||= Page
      p = p.where("UPPER(page_title) LIKE UPPER(?)", "%#{k}%")
    end
    p
  end
end
