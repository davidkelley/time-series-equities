require 'base64'

# Module that enables the API to control paginated requests for resources.
# This module should be used as a mixin whenever a Controller requires
# paginated requests for resources.
module PaginationHelper
  extend Grape::API::Helpers

  params :pagination do
    optional :cursor, type: String, desc: 'Cursor pointing to the next page of results'
  end

  def paginate(array, cursor)
    header 'X-Cursor', encoded(cursor)
    present array
  end

  def decoded(cursor)
    JSON.parse(Base64.decode64(cursor))
  end

  def decoded_cursor
    decoded(params[:cursor])
  end

  private

  def encoded(cursor)
    if cursor
      Base64.encode64(cursor.to_json).strip
    else
      ""
    end
  end
end
