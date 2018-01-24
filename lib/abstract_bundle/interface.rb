# Small class to incluse interfaces on ruby classes
module AbstractBundle

  module Interface

    def self.included(klass)
      klass.send(:include, AbstractBundle::Interface::Methods)
      klass.send(:extend, AbstractBundle::Interface::Methods)
      klass.send(:extend, AbstractBundle::Interface::ClassMethods)
    end

    # base methods for interface required implementation
    module Methods
      def raise_not_implemented(method)
        raise AbstractBundle::NotImplementedError, "'#{method}' must be implemented"
      end

      def build_method(method)
        class_eval do
          define_method(method) { raise_not_implemented(method) }
        end
      end
    end

    # class method to setup needed implemented methods
    module ClassMethods
      def needs_implementation(*methods)
        methods.each { |method| build_method(method) }
      end
    end

  end
end
