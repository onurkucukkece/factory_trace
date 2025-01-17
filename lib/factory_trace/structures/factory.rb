module FactoryTrace
  module Structures
    class Factory
      include Helpers::Statusable

      attr_reader :names, :parent_name, :traits, :declaration_names

      # @param [Array<String>] names
      # @param [Array<FactoryTrace::Structure::Trait>] traits
      # @param [String|nil] parent_name
      # @param [Array<String>] declaration_names
      def initialize(names, traits, parent_name: nil, declaration_names: [])
        @names = names
        @traits = traits
        @parent_name = parent_name
        @declaration_names = declaration_names
      end

      # @return [Hash<Symbol, Object>]
      def to_h
        {
          names: names,
          traits: traits.map(&:to_h),
          parent_name: parent_name,
          declaration_names: declaration_names
        }
      end

      # Merge passed factory into self
      #
      # @param [FactoryTrace::Structures::Factory]
      def merge!(factory)
        factory.traits.each do |trait|
          traits << trait unless traits.any? { |t| t.name == trait.name }
        end
      end

      # @return [Boolean]
      def ==(factory)
        return false unless factory.is_a?(FactoryTrace::Structures::Factory)

        names == factory.names &&
          traits == factory.traits &&
          parent_name == factory.parent_name &&
          declaration_names == factory.declaration_names
      end
    end
  end
end
