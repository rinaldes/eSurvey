module ApplicationHelper
	def pagination_links(collection, options = {})
   options[:renderer] ||= BootstrapPaginationHelper::LinkRenderer
   options[:inner_window] ||= 1
   options[:outer_window] ||= 0
   will_paginate(collection, options)
 end
end
