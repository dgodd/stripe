require "./stripe/*"

module Stripe
  macro class_property(*names)
    {% for name in names %}
      @@{{name}}

      def self.{{name.var.id}} : {{name.type}}
        @@{{name.var.id}}
      end

      def self.{{name.var.id}}=(val : {{name.type}})
        @@{{name.var.id}} = val
      end
    {% end %}
  end

  class_property api_key : String?
  class_property public_key : String?
end
