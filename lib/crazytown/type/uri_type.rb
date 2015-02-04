require 'crazytown/type'
require 'crazytown/simple_struct'
require 'uri'

module Crazytown
  module Type
    #
    # Type for URIs.
    #
    # Allows URIs to be specified as URI or as String.  Can also handle absolutizing
    # relative URLs with #relative_to.
    #
    class URIType
      extend Type
      extend SimpleStruct

      must_be_kind_of URI

      def self.coerce(parent, uri)
        if uri
          rel = relative_to(parent: parent)
          if rel
            uri = rel + uri
          else
            uri = URI.parse(uri) if uri.is_a?(String)
          end
        end
        super
      end

      class <<self
        extend SimpleStruct
        attribute :relative_to, coerced: "value.is_a?(String) ? URI.parse(value) : value"
      end
    end
  end
end
