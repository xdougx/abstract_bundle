# Module base for pagination
module Pageable
  extend ActiveSupport::Concern

  # Module base for pagination
  module ClassMethods
    cattr_accessor :page_size

    def paginate(page, per_page = 20, device = '', options = {})
      current = { objects: [], pagination: { current_page: page, total_objects: count, per_page: per_page, total_pages: total_pages(per_page, page) } }

      if page == 'all'
        current[:objects] = offset(0).json(device, options)
      else
        per_page = per_page.blank? ? 20 : per_page
        page = page.blank? ? 0 : (per_page * (page - 1))
        current[:objects] = offset(page).limit(per_page).json(device, options)
      end

      current
    end

    def total_pages(per_page, page)
      page == 'all' ? 1 : (count.to_f / per_page.to_f).ceil
    end
  end
end
