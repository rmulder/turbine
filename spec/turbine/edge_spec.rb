require 'spec_helper'

describe 'Turbine::Edge' do
  let(:left)  { Turbine::Node.new(:gloria) }
  let(:right) { Turbine::Node.new(:jay) }
  let(:edge)  { Turbine::Edge.new(left, right, :married) }

  context 'creating a new edge' do
    it 'should assign the to node' do
      expect(edge.to).to eql(right)
    end

    it 'should assign the from node' do
      expect(edge.from).to eql(left)
    end

    it 'should assign the label' do
      expect(edge.label).to eql(:married)
    end

    context 'without a "to" node' do
      it { expect(->{ Turbine::Edge.new }).to raise_error(ArgumentError) }
    end

    context 'without an "from" node' do
      it do
        expect(->{ Turbine::Edge.new(Turbine::Node.new(:gloria)) }).
          to raise_error(ArgumentError)
      end
    end

    context 'providing no properties' do
      it 'should not set any proeprties' do
        edge = Turbine::Edge.new(left, right, :married)
        expect(edge.properties).to be_empty
      end
    end

    context 'providing no hash' do
      it 'should not set any properties' do
        edge = Turbine::Edge.new(left, right, :married)
        expect(edge.properties).to be_empty
      end
    end

    context 'providing a properties hash' do
      it 'should set the properties' do
        edge = Turbine::Edge.new(left, right, :married, { b: 2, c: 3 })
        expect(edge.properties).to eql(b: 2, c: 3)
      end
    end
  end # creating a new edge

  # --------------------------------------------------------------------------

  describe 'nodes' do
    context 'with :to' do
      it 'returns the connected-to node' do
        expect(edge.nodes(:to)).to eql(right)
      end
    end

    context 'with :from' do
      it 'returns the connected-from node' do
        expect(edge.nodes(:from)).to eql(left)
      end
    end
  end # nodes

  # --------------------------------------------------------------------------

  describe '#inspect' do
    let(:inspected) { edge.inspect }

    it 'should include the from node' do
      expect(inspected).to include(left.key.to_s)
    end

    it 'should include the to node' do
      expect(inspected).to include(right.key.to_s)
    end

    it 'should include the label' do
      expect(inspected).to include(edge.label.to_s)
    end
  end # #inspect
end # Turbine::Edge
