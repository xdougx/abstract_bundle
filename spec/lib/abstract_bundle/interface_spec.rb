# require 'spec_helper'

RSpec.describe AbstractBundle::Interface do
  before(:all) do
    Object.include(AbstractBundle::Interface)
  end

  describe 'implementation required' do

    it 'should respond to needs_implementation' do
      expect(Object).to respond_to(:needs_implementation)
    end

    describe 'when the method is not implemented' do

      before do
        Object.class_eval do
          needs_implementation 'method_test'
        end
      end

      let(:object) { Object.new }

      it 'should raise NotImplementedError if methods not implemented' do
        expect{ object.method_test }.to raise_error { AbstractBundle::NotImplementedError }
      end
    end

    describe 'when is implemented' do
      before do
        Object.class_eval do
          needs_implementation 'method_test'

          def method_test
            true
          end
        end
      end

      let(:object) { Object.new }

      it 'should be true if method is implemented' do
        expect(object.method_test).to be(true)
      end

    end

  end


end